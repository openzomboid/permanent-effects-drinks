--
-- Copyright (c) 2022 outdead.
-- Use of this source code is governed by the Apache 2.0 license.
--
-- Permanent Effects Drinks adds drinks with a permanent effect
--

-- OnEat_GreedySalvation cures zombie virus.
function OnEat_GreedySalvation(food, player, percent)
    if percent < 1 then
        player:Say(getText("Moodles_nothing_happened"))
        return
    end

    local bodyDamage = player:getBodyDamage();

    bodyDamage:setInfected(false);
    bodyDamage:setInfectionMortalityDuration(-1);
    bodyDamage:setInfectionTime(-1);
    bodyDamage:setInfectionLevel(0);

    local bodyParts = bodyDamage:getBodyParts();
    for i=bodyParts:size()-1, 0, -1  do
        local bodyPart = bodyParts:get(i);
        bodyPart:SetInfected(false);
    end
end
