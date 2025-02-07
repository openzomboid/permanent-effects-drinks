--
-- Copyright (c) 2025 outdead.
-- Use of this source code is governed by the Apache 2.0 license
-- that can be found in the LICENSE file.
--

MoonshineRecipesServer = {}

function MoonshineRecipesServer.GetDefaultRecipes()
    local pzversion = string.sub(getCore():getVersionNumber(), 1, 2)

    local recipes = {
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

    if pzversion == "41" then
        recipes = {
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

    return recipes
end

function MoonshineRecipesServer.OnClientCommand(module, command, character, args)
    print("BBB: MoonshineOnClientCommand 1")

    if module ~= "Permanent" then
        return
    end

    print("BBB: MoonshineOnClientCommand 2")

    if command == "GetRecipes" then
        print("BBB: MoonshineOnClientCommand 3")

        if isServer() then
            sendServerCommand(character, "Permanent", "GetRecipes", {recipes = MoonshineRecipesServer.GetDefaultRecipes()})
        else
            MoonshineRecipesClient.Recipes = MoonshineRecipesServer.GetDefaultRecipes()
        end
    end
end

Events.OnClientCommand.Add(MoonshineRecipesServer.OnClientCommand)
