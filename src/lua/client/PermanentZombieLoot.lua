--
-- Copyright (c) 2025 outdead.
-- Use of this source code is governed by the MIT license
-- that can be found in the LICENSE file.
--

PermanentZombieLoot = {}

function PermanentZombieLoot.CheckChance(chance)
    local rand = ZombRand(chance)

    return rand <= chance
end

function PermanentZombieLoot.OnZombieDead(corpse)
    if corpse == nil then
        return
    end

    local character = getPlayer()

    local zombieX = math.floor(corpse:getX());
    local zombieY = math.floor(corpse:getY());
    local zombieIsRunner = false;
    local zombieKiller = -1;
    local zombieInventory = corpse:getInventory();

    for i = 0, getNumClassFields(corpse) - 1 do
        local field = getClassField(corpse, i)

        if tostring(field) == "public boolean zombie.characters.IsoZombie.bRunning" then
            zombieIsRunner = getClassFieldVal(corpse, field);
        end

        if tostring(field) == "public int zombie.characters.IsoZombie.lastPlayerHit" then
            zombieKiller = getClassFieldVal(corpse, field);
        end
    end

    local roomName = ""
    local square = corpse:getSquare()
    if square then
        local room = square:getRoom()

        if room then
            local roomDef = room:getRoomDef()
            if roomDef then
                roomName = roomDef:getName()
            end
        end
    end

    local msg = "Permanent Log: "
            .. " zombieX = " .. tostring(zombieX) .. " zombieY = " .. tostring(zombieY)
            .. " isRunner = " .. tostring(zombieIsRunner) .. " killer = " .. tostring(zombieKiller)
            .. " roomName = " .. roomName
    print(msg);

    if roomName == "bar" then
        zombieInventory:AddItems("Permanent.ExclusiveRecipe", 1);
    end
end

Events.OnZombieDead.Add(PermanentZombieLoot.OnZombieDead);
