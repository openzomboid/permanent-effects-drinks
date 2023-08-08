--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the MIT license
-- that can be found in the LICENSE file.
--

PermanentRecipes = {
    MakeWhiskey = {
        --animationType = "Shoveling",
        sound = "PourWaterIntoObject",
        time = 300,
        cookingSkill = 3,
        usedItems = {
            ["Base.WhiskeyWaterFull"] = 1,
        },
        results = {
            ["Base.WhiskeyFull"] = 1,
        }
    },
}
