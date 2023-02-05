--
-- Copyright (c) 2022 outdead.
-- Use of this source code is governed by the Apache 2.0 license.
--
-- Permanent Effects Drinks adds drinks with a permanent effect
--

local version = "0.9.0"

local pzversion = getCore():getVersionNumber()

-- SlenderDoeSetWeight contains the weight value that will be set to
-- the character after applying the drink.
local SlenderDoeSetWeight = 80

-- PerkLevelup creates level up for perk.
function PerkLevelup(player, perkType)
    local perkLevel = player:getPerkLevel(perkType);

    if perkLevel < 10 then
        local xp = player:getXp()
        local xpTotal = xp:getXP(perkType)
        local xpInLevel = xpTotal - ISSkillProgressBar.getPreviousXpLvl(perkType, perkLevel)
        if xpInLevel < 0 then
            xpInLevel = 0
        end

        player:LevelPerk(perkType, false);
        player:getXp():setXPToLevel(perkType, player:getPerkLevel(perkType));
        SyncXp(player)

        player:getXp():AddXPNoMultiplier(perkType, xpInLevel);
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

-- DrinkSlipperyFish adds action to drink Permanent.SlipperyFish.
-- Permanently increases Nimble by 1.
function DrinkSlipperyFish(items, result, player)
    PerkLevelup(player, Perks.Nimble);
end

-- DrinkSlenderDoe adds action to drink Permanent.SlenderDoe.
function DrinkSlenderDoe(items, result, player)
    player:getNutrition():setWeight(SlenderDoeSetWeight);

    if player:HasTrait("Overweight") then
        player:getTraits():remove("Overweight");
    end

    if player:HasTrait("Underweight") then
        player:getTraits():remove("Underweight");
    end

    if player:HasTrait("Obese") then
        player:getTraits():remove("Obese");
    end

    if player:HasTrait("Very Underweight") then
        player:getTraits():remove("Very Underweight");
    end
end

-- DrinkNicotineOverdose adds action to drink Permanent.NicotineOverdose.
function DrinkNicotineOverdose(items, result, player)
    if player:HasTrait("Smoker") then
        player:getTraits():remove("Smoker");
        player:getStats():setStressFromCigarettes(0);
        player:setTimeSinceLastSmoke(0);
    end
end

-- TODO: Add maintenance drink
