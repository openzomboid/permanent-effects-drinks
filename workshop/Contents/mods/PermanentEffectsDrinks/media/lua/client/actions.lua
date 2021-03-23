--
-- Copyright (c) 2021 outdead.
-- Use of this source code is governed by the Apache 2.0 license.
--
-- Permanent Effects Drinks adds drinks with a permanent effect
--

local version = "0.3.1"

-- SlenderDoeSetWeight contains the weight value that will be set to
-- the character after applying the drink.
local SlenderDoeSetWeight = 80

-- PerkLevelup creates level up for perk.
function PerkLevelup(player, perkType, addGlobalXP)
    local perkLevel = player:getPerkLevel(perkType);

    if perkLevel < 10 then
        local perk = PerkFactory.getPerk(perkType);
        local amount = perk:getXpForLevel(perkLevel + 1);

        player:getXp():AddXP(perkType, amount, false, false, false, true);

        if not perk:isPassiv() then
            -- if addGlobalXP is false current skill points will be used.
            if addGlobalXP then
                -- add XP only for one level.
                local playerLevel = player:getXp():getLevel()

                -- add 1 to xp to increase the global level. Otherwise the level does not increase,
                -- and the amount of experience required for the next level takes the value 0.
                local xpForNextLevel = toInt(player:getXpForLevel(playerLevel) - player:getXp():getTotalXp()) + 1;

                player:getXp():addGlobalXP(xpForNextLevel);
            end

            -- create level up and recalculate XP to next level.
            player:LevelPerk(perkType);
            player:getXp():setXPToLevel(perkType, player:getPerkLevel(perkType));
        end
    end
end

-- DrinkHastyHerring adds action to drink BarMenu.HastyHerring.
function DrinkHastyHerring(items, result, player)
    PerkLevelup(player, Perks.Sprinting, true);
end

-- DrinkDoubleHastyHerring adds action to drink BarMenu.DoubleHastyHerring.
function DrinkDoubleHastyHerring(items, result, player)
    PerkLevelup(player, Perks.Sprinting, true);
    PerkLevelup(player, Perks.Fitness, false);
end

-- DrinkGreedyHammer adds action to drink BarMenu.GreedyHammer.
function DrinkGreedyHammer(items, result, player)
    PerkLevelup(player, Perks.Blunt, true);
end

-- DrinkDoubleGreedyHammer adds action to drink BarMenu.DoubleGreedyHammer.
function DrinkDoubleGreedyHammer(items, result, player)
    PerkLevelup(player, Perks.Blunt, true);
    PerkLevelup(player, Perks.Strength, false);
end

-- DrinkGreedyAxe adds action to drink BarMenu.GreedyAxe.
function DrinkGreedyAxe(items, result, player)
    PerkLevelup(player, Perks.Axe, true);
end

-- DrinkDoubleGreedyAxe adds action to drink BarMenu.DoubleGreedyAxe.
function DrinkDoubleGreedyAxe(items, result, player)
    PerkLevelup(player, Perks.Axe, true);
    PerkLevelup(player, Perks.Strength, false);
end

-- DrinkStrayBullet adds action to drink BarMenu.StrayBullet.
function DrinkStrayBullet(items, result, player)
    PerkLevelup(player, Perks.Aiming, true);
end

-- DrinkSlenderDoe adds action to drink BarMenu.SlenderDoe.
function DrinkSlenderDoe(items, result, player)
    player:getNutrition():setWeight(SlenderDoeSetWeight);
end
