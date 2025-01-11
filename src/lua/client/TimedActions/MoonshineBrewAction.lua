--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the MIT license
-- that can be found in the LICENSE file.
--

require "TimedActions/ISBaseTimedAction"
require 'MoonshineRecipes'

MoonshineBrewAction = ISBaseTimedAction:derive("MoonshineBrewAction");

function MoonshineBrewAction:new(character, recipe, object)
    local cookingLevel = character:getPerkLevel(Perks.Cooking)

    local o = {}
    setmetatable(o, self)
    self.__index = self
    o.character = character;
    o.stopOnWalk = true;
    o.stopOnRun = true;
    o.maxTime = recipe.time - (cookingLevel * 20 - 100);
    -- custom fields
    o.object = object
    o.recipe = recipe
    return o
end

function MoonshineBrewAction:isValid()
    if not MoonshineRecipes.IsEnoughMaterials(self.character, self.recipe) then
        return false
    end

    if not MoonshineRecipes.IsEnoughFluids(self.character, self.recipe) then
        return false
    end

    return true
end

function MoonshineBrewAction:waitToStart()
    return false
end

function MoonshineBrewAction:update()
end

-- start starts brewing action.
-- TODO: Add animation.
-- local animation = MoonshineRecipes.GetAnimation(self.recipe.animationType)
-- self:setActionAnim(animation).
function MoonshineBrewAction:start()
    self.sound = self.character:playSound(self.recipe.sound)
end

function MoonshineBrewAction:stop()
    ISBaseTimedAction.stop(self);
end

function MoonshineBrewAction:perform()
    local inventory = self.character:getInventory()

    self:takeMaterials()
    self:takeFluids()

    -- Add results to player inventory.
    inventory:AddItems(self.recipe.result, 1)
    for itemCode, addItemsCount in pairs(self.recipe.additionalResults) do
        inventory:AddItems(itemCode, addItemsCount)
    end

    return self:performNext()
end

-- performNext removes action from queue and allows to start next action.
function MoonshineBrewAction:performNext()
    ISBaseTimedAction.perform(self)
end

function MoonshineBrewAction:takeMaterials()
    local inventory = self.character:getInventory()

    for itemCode, neededItemsCount in pairs(self.recipe.usedItems) do
        local items = inventory:getAllType(itemCode)

        if items:size() < neededItemsCount then
            return self:performNext()
        end

        local removedItemsCount = 0

        for i=1, items:size() do
            local itemToRemove = items:get(i-1)

            if not MoonshineRecipes.IsItemBlocked(self.character, itemToRemove) then
                if removedItemsCount >= neededItemsCount then
                    break
                end

                if itemToRemove:getContainer() then
                    itemToRemove:getContainer():Remove(itemToRemove)
                else
                    inventory:Remove(itemToRemove)
                end

                removedItemsCount = removedItemsCount + 1
            end
        end

        if removedItemsCount ~= neededItemsCount then
            return self:performNext()
        end
    end
end

function MoonshineBrewAction:takeFluids()
    local inventory = self.character:getInventory()

    if not self.recipe.fluids then
        return
    end

    for itemCode, fluid in pairs(self.recipe.fluids) do
        local items = inventory:getAllType(itemCode)

        if items:size() < 1 then
            return self:performNext()
        end

        local removedItemsCount = 0

        for i=1, items:size() do
            local itemToRemove = items:get(i-1)

            if not MoonshineRecipes.IsItemBlocked(self.character, itemToRemove) and MoonshineRecipes.IsFluidReady(itemToRemove, fluid) then
                if removedItemsCount >= 1 then
                    break
                end

                if itemToRemove:getContainer() then
                    itemToRemove:getContainer():Remove(itemToRemove)
                else
                    inventory:Remove(itemToRemove)
                end

                removedItemsCount = removedItemsCount + 1
            end
        end

        if removedItemsCount ~= 1 then
            return self:performNext()
        end
    end
end
