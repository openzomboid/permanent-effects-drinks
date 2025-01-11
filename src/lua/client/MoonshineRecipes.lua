--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the MIT license
-- that can be found in the LICENSE file.
--

MoonshineRecipes = {
    -- TODO: Add possibility to create custom recipes in server side Lua directory.
    Recipes = {
        Vanilla = {
            {
                name = "MakeWhiskey",
                type = "Vanilla",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "Item_WhiskeyFull",
                time = 300,
                cookingSkill = 3,
                usedItems = {
                    ["Base.BottleCrafted"] = 1,
                    ["Base.Yeast"] = 1,
                    ["Base.Corn"] = 1,
                    ["Base.UnusableWood"] = 1,
                },
                result = "Base.WhiskeyFull",
                additionalResults = {},
            },
            {
                name = "MakeWine",
                type = "Vanilla",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "Item_Wine2Full",
                time = 300,
                cookingSkill = 3,
                usedItems = {
                    ["Base.BottleCrafted"] = 1,
                    ["Base.Sugar"] = 1,
                    ["Base.Grapes"] = 1,
                },
                result = "Base.Wine2",
                additionalResults = {},
            },
            {
                name = "MakeBeer",
                type = "Vanilla",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "Item_BeerBottle",
                time = 300,
                cookingSkill = 3,
                usedItems = {
                    ["Base.BottleCrafted"] = 1,
                    ["Base.Sugar"] = 1,
                    ["Base.Corn"] = 1,
                },
                result = "Base.BeerBottle",
                additionalResults = {},
            },
        },

        Exclusive = {
            {
                name = "MakeSlenderDoe",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_SlenderDoe.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.GrapeLeaves"] = 4,
                    ["Base.Pickles"] = 1,
                },
                fluids = {
                    ["Base.Wine"] = {
                        code = "Base.Wine",
                        name = "Wine",
                        amount = 1,
                    },
                    ["Base.Wine2"] = {
                        code = "Base.Wine2",
                        name = "Wine",
                        amount = 1,
                    },
                    ["Base.Milk"] = {
                        code = "Base.Milk",
                        name = "CowMilk",
                        amount = 1,
                    },
                },
                result = "Permanent.SlenderDoe",
                additionalResults = {},
            },
            {
                name = "MakeNicotineOverdose",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_NicotineOverdose.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.Sugar"] = 1,
                    ["Base.CigaretteSingle"] = 100,
                    ["Base.Coffee2"] = 5,
                },
                fluids = {
                    ["Base.Whiskey"] = {
                        code = "Base.Whiskey",
                        name = "Whiskey",
                        amount = 1,
                    },
                },
                result = "Permanent.NicotineOverdose",
                additionalResults = {},
            },
        },
    }
}

local pzversion = string.sub(getCore():getVersionNumber(), 1, 2)

if pzversion == "41" then
    MoonshineRecipes.Recipes = {
        Vanilla = {
            ["MakeWhiskey"] = {
                name = "MakeWhiskey",
                type = "Vanilla",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "Item_WhiskeyFull",
                time = 300,
                cookingSkill = 3,
                usedItems = {
                    ["Base.WhiskeyWaterFull"] = 1,
                    ["Base.Yeast"] = 1,
                    ["Base.Corn"] = 1,
                    ["Base.UnusableWood"] = 1,
                },
                result = "Base.WhiskeyFull",
                additionalResults = {},
            },
            ["MakeWine"] = {
                name = "MakeWine",
                type = "Vanilla",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "Item_Wine2Full",
                time = 300,
                cookingSkill = 3,
                usedItems = {
                    ["Base.WineWaterFull"] = 1,
                    ["Base.Sugar"] = 1,
                    ["Base.Grapes"] = 1,
                },
                result = "Base.Wine2",
                additionalResults = {},
            },
            ["MakeBeer"] = {
                name = "MakeBeer",
                type = "Vanilla",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "Item_BeerBottle",
                time = 300,
                cookingSkill = 3,
                usedItems = {
                    ["Base.BeerWaterFull"] = 1,
                    ["Base.Sugar"] = 1,
                    ["Base.Corn"] = 1,
                },
                result = "Base.BeerBottle",
                additionalResults = {},
            },
        },

        Exclusive = {
            ["MakeSlenderDoe"] = {
                name = "MakeSlenderDoe",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_SlenderDoe.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.Wine2"] = 1,
                    ["Base.Wine"] = 1,
                    ["Base.GrapeLeaves"] = 4,
                    ["Base.Milk"] = 1,
                    ["Base.Pickles"] = 1,
                },
                result = "Permanent.SlenderDoe",
                additionalResults = {},
            },
            ["MakeNicotineOverdose"] = {
                name = "MakeNicotineOverdose",
                type = "Exclusive",
                disabled = false,
                sound = "PourWaterIntoObject",
                texture = "media/textures/Item_NicotineOverdose.png",
                time = 300,
                cookingSkill = 10,
                usedItems = {
                    ["Permanent.ExclusiveRecipe"] = 1,
                    ["Base.WhiskeyFull"] = 1,
                    ["Base.Sugar"] = 1,
                    ["Base.Cigarettes"] = 1000,
                    ["Base.Coffee2"] = 5,
                },
                result = "Permanent.NicotineOverdose",
                additionalResults = {},
            },
        },
    }
end

function MoonshineRecipes.IsEnoughMaterials(character, recipe)
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

            if not MoonshineRecipes.IsItemBlocked(character, itemToRemove) then
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

function MoonshineRecipes.IsEnoughFluids(character, recipe)
    if not recipe then return false end

    local inventory = character:getInventory()

    if recipe.fluids then
        for itemCode, fluid in pairs(recipe.usedItems) do
            local items = inventory:getAllType(itemCode)

            if not items or items:size() < 1 then
                return false
            end

            local inventoryItemsCount = 0

            for i=1, items:size() do
                local itemToRemove = items:get(i-1)

                if not MoonshineRecipes.IsItemBlocked(character, itemToRemove) and MoonshineRecipes.IsFluidReady(itemToRemove, fluid) then
                    if inventoryItemsCount >= 1 then
                        break
                    end

                    inventoryItemsCount = inventoryItemsCount + 1
                end
            end

            if inventoryItemsCount ~= 1 then
                return false
            end
        end
    end

    return true
end

function MoonshineRecipes.IsItemBlocked(character, item)
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

function MoonshineRecipes.IsFluidReady(item, fluid)
    if not fluid then
        return true
    end

    if item:getFullType() ~= fluid.code then
        return true
    end

    -- Temporary true while b42 is unstable.
    -- TODO: Return false if item is not a FluidContainer.
    if not item.getFluidContainer then
        return true
    end

    local fluidContainer = item:getFluidContainer()

    if fluidContainer:isEmpty() then
        return false
    end

    local primaryFluid = fluidContainer:getPrimaryFluid()
    if not primaryFluid then
        return false
    end

    local primaryFluidName = primaryFluid:toString()
    if primaryFluidName ~= fluid.name then
        return false
    end

    local primaryFluidAmount = fluidContainer:getPrimaryFluidAmount()
    if primaryFluidAmount < fluid.amount then
        return false
    end

    return true
end
