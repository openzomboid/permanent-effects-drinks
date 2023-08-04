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
                PermanentBuildMenu.RegisterLines(player, context, worldobjects, buildMenu)
            end
        end
    end

    return true
end

Events.OnFillWorldObjectContextMenu.Add(PermanentContextMenu.doContextMenu);
