--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the MIT license
-- that can be found in the LICENSE file.
--

if isClient() then return end;

require 'Items/SuburbsDistributions'

PermanentSuburbsDistributions = {}

-- addZombieLoot adds chance to spawn some loot in zombies.
local function addZombieLoot()
    if not SandboxVars.Permanent.AllowExclusiveRecipeInZombieLoot then
        return
    end

    if SandboxVars.Permanent.ExclusiveRecipeInAllZombiesLootChance > 0 then
        -- Zombie Male
        table.insert(SuburbsDistributions["all"]["inventorymale"].items, "Permanent.ExclusiveRecipe");
        table.insert(SuburbsDistributions["all"]["inventorymale"].items, SandboxVars.Permanent.ExclusiveRecipeInAllZombiesLootChance);

        -- Zombie Female
        table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, "Permanent.ExclusiveRecipe");
        table.insert(SuburbsDistributions["all"]["inventoryfemale"].items, SandboxVars.Permanent.ExclusiveRecipeInAllZombiesLootChance);
    end
end

PermanentSuburbsDistributions.postDistributionMerge = function()
    addZombieLoot()
end

Events.OnPostDistributionMerge.Add(PermanentSuburbsDistributions.postDistributionMerge)

