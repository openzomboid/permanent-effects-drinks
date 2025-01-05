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

    local x = math.floor(corpse:getX());
    local y = math.floor(corpse:getY());
    local z = math.floor(corpse:getZ());
    local isSprinter = false;
    local zombieInventory = corpse:getInventory();

    for i = 0, getNumClassFields(corpse) - 1 do
        local field = getClassField(corpse, i)

        if tostring(field) == "public boolean zombie.characters.IsoZombie.bRunning" then
            isSprinter = getClassFieldVal(corpse, field);
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

    if roomName == "bar" then
        if PermanentZombieLoot.CheckChance(25) then
            zombieInventory:AddItems("Permanent.ExclusiveRecipe", 1);
        end
    end
end

Events.OnZombieDead.Add(PermanentZombieLoot.OnZombieDead);
