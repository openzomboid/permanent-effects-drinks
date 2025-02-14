--
-- Copyright (c) 2025 outdead.
-- Use of this source code is governed by the Apache 2.0 license
-- that can be found in the LICENSE file.
--

local json = require "vendor/json/json"
local json_pretty_options = {pretty = true, indent = "  ", align_keys = false, array_newline = true}

-- MoonshineRecipesServer contains recipes for moonshine still.
MoonshineRecipesServer = {}

-- GetDefaultRecipes returns default recipes.
function MoonshineRecipesServer.GetDefaultRecipes()
    local recipes = {
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

    local pzversion = string.sub(getCore():getVersionNumber(), 1, 2)
    if pzversion == "42" then
        recipes = {
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
                        ["Base.Wine"] = {name = "Wine", amount = 1},
                        ["Base.Wine2"] = {name = "Wine", amount = 1},
                        ["Base.Milk"] = {name = "CowMilk", amount = 1},
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
                        ["Base.Whiskey"] = {name = "Whiskey", amount = 1},
                    },
                    result = "Permanent.NicotineOverdose",
                    additionalResults = {},
                },
            },
        }
    end

    return recipes
end

-- LoadRecipes gets and returns recipes from moonshine-pecipes.json
-- file in Zomboid/Lua directory.
function MoonshineRecipesServer.LoadRecipes()
    if MoonshineRecipesServer.Recipes then
        return MoonshineRecipesServer.Recipes
    end

    local recipeFileName = "moonshine-recipes.json"
    local pzversion = string.sub(getCore():getVersionNumber(), 1, 2)
    if pzversion == "42" then
        recipeFileName = "moonshine-recipes-b42.json"
    end

    local recipes = MoonshineRecipesServer.ReadFile(recipeFileName)
    if not recipes then
        recipes = MoonshineRecipesServer.GetDefaultRecipes()

        MoonshineRecipesServer.WriteFile(recipeFileName, recipes)
    end

    MoonshineRecipesServer.Recipes = recipes

    return recipes
end

-- WriteFile saves values to file in Zomboid/Lua directory.
-- TODO: Add function to openutils.
function MoonshineRecipesServer.WriteFile(filename, data)
    local writer = getFileWriter(filename, false, false)
    if not writer then
        return false
    end

    if data ~= nil then
        local encodeddata = json:encode_pretty(data, nil, json_pretty_options)
        if encodeddata ~= nil then
            writer:write(encodeddata)
        end
    end

    writer:close()

    return true
end

-- ReadFile reads instance values from file in Zomboid/Lua directory.
-- TODO: Add function to openutils.
function MoonshineRecipesServer.ReadFile(filename)
    local reader = getFileReader(filename, false)
    if not reader then
        return
    end

    local rawdata = ""

    while true do
        local line = reader:readLine()
        if not line then
            reader:close()
            break
        end

        rawdata = rawdata .. line
    end

    if rawdata ~= "" then
        local data = json:decode(rawdata)
        return data
    end
end

-- OnClientCommand handles commands from client.
function MoonshineRecipesServer.OnClientCommand(module, command, character, args)
    if module ~= "Permanent" then
        return
    end

    if command == "GetRecipes" then
        local recipes = MoonshineRecipesServer.LoadRecipes()

        if isServer() then
            sendServerCommand(character, "Permanent", "GetRecipes", {recipes = recipes})
        else
            MoonshineRecipesClient.Recipes = recipes
        end
    end
end

-- OnServerStarted handles OnServerStarted Lua event.
function MoonshineRecipesServer.OnServerStarted()
    local _ = MoonshineRecipesServer.LoadRecipes()
end

Events.OnClientCommand.Add(MoonshineRecipesServer.OnClientCommand)
Events.OnServerStarted.Add(MoonshineRecipesServer.OnServerStarted)
