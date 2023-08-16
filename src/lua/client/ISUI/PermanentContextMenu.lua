--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the MIT license
-- that can be found in the LICENSE file.
--

-- PermanentContextMenu is the game context menu extender.
PermanentContextMenu = {}

-- doContextMenu adds the "Permanent" item to the context menu.
PermanentContextMenu.doContextMenu = function(player, context, worldobjects, test)
    if test and ISWorldObjectContextMenu.Test then return true end

    if SandboxVars.Permanent.CanBuildMoonshineStill or isAdmin() then
        local buildOption = context:getOptionFromName(getText("ContextMenu_Build"))
        if buildOption then
            local buildMenu = context:getSubMenu(buildOption.subOption)
            if buildMenu then
                local moonshineOption = buildMenu:addOption(getText("ContextMenu_Moonshine"), worldobjects, nil);
                local moonshineMenu = ISContextMenu:getNew(context);
                context:addSubMenu(moonshineOption, moonshineMenu);

                PermanentBuildMenu.RegisterLines(player, context, worldobjects, moonshineMenu)
            end
        end
    end

    local character = getSpecificPlayer(player)

    local object = worldobjects[1];
    local square = object:getSquare()
    local sprite = object:getSprite()

    if character:getVehicle() then
        return true
    end

    local isMoonshineStill

    for i=1, square:getObjects():size() do
        local o = square:getObjects():get(i-1)

        if sprite and sprite:getName() then
            local spriteName = sprite:getName()

            isMoonshineStill = spriteName == "MoonshineStill_0" or spriteName == "MoonshineStill_1" or
                spriteName == "MoonshineStill_2" or spriteName == "MoonshineStill_3"
        end
    end

    if isMoonshineStill and (SandboxVars.Permanent.AllowBrewingVanillaAlcohol or SandboxVars.Permanent.AllowBrewingExclusiveAlcohol) then
        local distilOption = context:addOption(getText("ContextMenu_DistillAlcohol"), worldobjects, nil);
        local distilMenu = ISContextMenu:getNew(context);
        context:addSubMenu(distilOption, distilMenu);

        if SandboxVars.Permanent.AllowBrewingVanillaAlcohol then
            -- TODO: Implement me.
        end

        if SandboxVars.Permanent.AllowBrewingExclusiveAlcohol then
            -- TODO: Implement me.
        end
    end

    return true
end

Events.OnFillWorldObjectContextMenu.Add(PermanentContextMenu.doContextMenu);
