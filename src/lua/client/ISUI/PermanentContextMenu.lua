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

    if not isAdmin() then
        return
    end;

    local adminOption = context:addOption("Permanent", worldobjects, nil);
    local adminSubMenu = ISContextMenu:getNew(context);
    context:addSubMenu(adminOption, adminSubMenu);

    PermanentBuildMenu.RegisterLines(player, context, worldobjects, adminSubMenu)

    return true
end

Events.OnFillWorldObjectContextMenu.Add(PermanentContextMenu.doContextMenu);
