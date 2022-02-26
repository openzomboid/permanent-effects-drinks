--
-- Copyright (c) 2021 outdead.
-- Use of this source code is governed by the Apache 2.0 license.
--
-- Permanent Effects Drinks adds drinks with a permanent effect
--

local version = "0.7.1"

local pzversion = getCore():getVersionNumber()

-- SlenderDoeSetWeight contains the weight value that will be set to
-- the character after applying the drink.
local SlenderDoeSetWeight = 80

-- PerkLevelup creates level up for perk.
function PerkLevelup(player, perkType)
    local perkLevel = player:getPerkLevel(perkType);

    if perkLevel < 10 then
        if pzversion == "41.65" then
            local perk = PerkFactory.getPerk(perkType);
            local amount = perk:getXpForLevel(perkLevel + 1);

            player:getXp():AddXP(perkType, amount, false, false, false, true);

            return
        end

        player:LevelPerk(perkType, false);
        player:getXp():setXPToLevel(perkType, player:getPerkLevel(perkType));
        SyncXp(player)
    end
end

-- DrinkHastyHerring adds action to drink Permanent.HastyHerring.
function DrinkHastyHerring(items, result, player)
    PerkLevelup(player, Perks.Sprinting);
end

-- DrinkDoubleHastyHerring adds action to drink Permanent.DoubleHastyHerring.
function DrinkDoubleHastyHerring(items, result, player)
    PerkLevelup(player, Perks.Sprinting);
    PerkLevelup(player, Perks.Fitness);
end

-- DrinkGreedyHammer adds action to drink Permanent.GreedyHammer.
function DrinkGreedyHammer(items, result, player)
    PerkLevelup(player, Perks.Blunt);
end

-- DrinkDoubleGreedyHammer adds action to drink Permanent.DoubleGreedyHammer.
function DrinkDoubleGreedyHammer(items, result, player)
    PerkLevelup(player, Perks.Blunt);
    PerkLevelup(player, Perks.Strength);
end

-- DrinkGreedyAxe adds action to drink Permanent.GreedyAxe.
function DrinkGreedyAxe(items, result, player)
    PerkLevelup(player, Perks.Axe);
end

-- DrinkDoubleGreedyAxe adds action to drink Permanent.DoubleGreedyAxe.
function DrinkDoubleGreedyAxe(items, result, player)
    PerkLevelup(player, Perks.Axe);
    PerkLevelup(player, Perks.Strength);
end

-- DrinkStrayBullet adds action to drink Permanent.StrayBullet.
function DrinkStrayBullet(items, result, player)
    PerkLevelup(player, Perks.Aiming);
end

-- DrinkSlenderDoe adds action to drink Permanent.SlenderDoe.
function DrinkSlenderDoe(items, result, player)
    player:getNutrition():setWeight(SlenderDoeSetWeight);
end

-- DrinkNicotineOverdose adds action to drink Permanent.NicotineOverdose.
function DrinkNicotineOverdose(items, result, player)
    if player:HasTrait("Smoker") then
        player:getTraits():remove("Smoker")
    end
end
