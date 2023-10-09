--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the MIT license
-- that can be found in the LICENSE file.
--

PermanentRecipes = {
    Recipes = {
        ["MakeWhiskey"] = {
            --animationType = "Shoveling",
            type = "Vanilla",
            sound = "PourWaterIntoObject",
            texture = "Item_WhiskeyFull",
            name = "ContextMenu_MakeWhiskey",
            time = 300,
            cookingSkill = 3,
            usedItems = {
                ["Base.WhiskeyWaterFull"] = 1,
                ["Base.Sugar"] = 1,
            },
            results = {
                ["Base.WhiskeyFull"] = 1,
            },
        },
        ["MakeNicotineOverdose"] = {
            --animationType = "Shoveling",
            type = "Exclusive",
            sound = "PourWaterIntoObject",
            texture = "Item_NicotineOverdose",
            name = "ContextMenu_MakeNicotineOverdose",
            time = 300,
            cookingSkill = 10,
            usedItems = {
                ["Base.WhiskeyFull"] = 1,
                ["Base.Sugar"] = 1,
                ["Base.Cigarettes"] = 1000,
                ["Base.Coffee2"] = 5,
            },
            results = {
                ["Permanent.NicotineOverdose"] = 1,
            },
        },
    },
}

PermanentRecipes.IsEnoughMaterials = function(character, recipe)
    if not recipe then return false end

    local inventory = character:getInventory()

    for itemCode, neededItemsCount in pairs(recipe.usedItems) do
        local items = inventory:getAllType(itemCode)

        if not items or items:size() < neededItemsCount then
            return false
        end

        local inventoryItemsCount = 0

        for i=1, items:size() do
            local itemToRemove = items:get(i-1)

            if not PermanentRecipes.IsItemBlocked(character, itemToRemove) then
                if inventoryItemsCount >= neededItemsCount then
                    break
                end

                inventoryItemsCount = inventoryItemsCount + 1
            end
        end

        if inventoryItemsCount ~= neededItemsCount then
            return false
        end
    end

    return true
end

PermanentRecipes.IsItemBlocked = function(character, item)
    if item:isBroken() then
        return true
    end

    if item:isFavorite() then
        return true
    end

    if item:isEquipped() then
        return true
    end

    return character:isEquipped(item) or character:isAttachedItem(item)
end
