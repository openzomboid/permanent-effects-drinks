--
-- Copyright (c) 2021 outdead.
-- Use of this source code is governed by the MIT license
-- that can be found in the LICENSE file.
--

function isClient()
    return true
end

function isServer()
    return false
end

local pzPath = os.getenv("PZ_PATH")

-- Import Tests utils.
dofile "testutils/testutils.lua"

-- Import Java zombie mock classes.
testutils.dotdir('mock/java')

---- Import Lua mock scripts.
--testutils.dotdir('mock/lua/mods')

-- Import Lua shared Project Zomboid original scripts.
dofile(pzPath.."/media/lua/shared/luautils.lua")
dofile(pzPath.."/media/lua/shared/defines.lua")
--testutils.dotdir(pzPath.."/media/lua/shared") -- TODO: Add all java classes mock first.
--testutils.dotdir(pzPath.."/media/lua/client") -- TODO: Add all java classes mock first.
package.path = pzPath.."/media/lua/shared/" .. "?.lua;" .. package.path
package.path = pzPath.."/media/lua/client/" .. "?.lua;" .. package.path

dofile(pzPath.."/media/lua/client/Chat/ISChat.lua") -- in ChatCommands.lua:9
dofile(pzPath.."/media/lua/client/TimedActions/ISReadABook.lua") -- in ISReadABook_ReadCouponLD10.lua
dofile(pzPath.."/media/lua/client/TimedActions/ISInventoryTransferAction.lua") -- in InventoryTransferAction_PreventMoveItems.lua:9
dofile(pzPath.."/media/lua/client/ISUI/ISWorldObjectContextMenu.lua") -- in PreventSafehouseZonesMenu.lua:11
dofile(pzPath.."/media/lua/client/ISUI/AdminPanel/ISAdminPanelUI.lua") -- in ISAdminPanelUI_AddDatabaseButton.lua:11
dofile(pzPath.."/media/lua/client/Vehicles/ISUI/ISVehicleMenu.lua") -- in DisassembleVehicleMenu.lua:19
dofile(pzPath.."/media/lua/client/TimedActions/ISDestroyStuffAction.lua") -- in ISDestroyStuffAction_ChangeDestroyTime.lua:9
dofile(pzPath.."/media/lua/client/OptionScreens/MainOptions.lua") -- in MainOptions_ForceChange.lua:11
dofile(pzPath.."/media/lua/client/TimedActions/ISReloadWeaponAction.lua") -- in ChangeJamGunChance.lua:11
dofile(pzPath.."/media/lua/client/TimedActions/ISTakeGenerator.lua") -- in ISTakeGenerator_EternalGeneratorPatch.lua:14
dofile(pzPath.."/media/lua/client/ISUI/ISInventoryPaneContextMenu.lua") -- in ISInventoryPaneContextMenu_FixFancyPack.lua:21

-- Import Lua mock scripts.
-- TODO: Automate Lua mods mocks.

function InitTest()
    -- Import mod scripts.
    package.path = "../src/lua/shared/vendor/json.lua;" .. package.path
    testutils.dotdir('../src/lua/shared')
    testutils.dotdir('../src/lua/client')

    -- Import mod tests.
    testutils.dotdirtests('../src/lua/client')
end

function ClearTest() end

InitTest()

--testutils.printTestFiles('../src/lua/client')
testutils.runtests()

ClearTest()
