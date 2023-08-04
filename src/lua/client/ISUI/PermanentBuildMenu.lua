--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the MIT license
-- that can be found in the LICENSE file.
--

-- PermanentBuildMenu contains build options.
PermanentBuildMenu = {}

-- RegisterLines adds options to click menu.
PermanentBuildMenu.RegisterLines = function(player, context, worldobjects, workbenchesSubMenu)
    local square = nil;

    -- Get the thumpable item (like wall/door/furniture etc.) if exist on the tile which right clicked.
    for i, v in ipairs(worldobjects) do
        square = v:getSquare();
    end

    local sprite = {};
    sprite.sprite1 = "MoonshineStill_1";
    sprite.sprite2 = "MoonshineStill_0";
    sprite.northSprite1 = "MoonshineStill_2";
    sprite.northSprite2 = "MoonshineStill_3";

    local option = workbenchesSubMenu:addOption("Moonshine Still", worldobjects, PermanentBuildMenu.onBuildMoonshineStill, square, sprite, player);
    local tooltip = ISBuildMenu.canBuild(48, 12, 0, 0, 0, 10, option, player);
    tooltip:setName("Moonshine Still");
    tooltip.description = getText("Moonshine Still") .. tooltip.description;
    tooltip:setTexture(sprite.sprite1);
end

-- onBuildMoonshineStill adds callback to build Moonshine Still option.
PermanentBuildMenu.onBuildMoonshineStill = function(worldobjects, square, sprite, player)
    -- name, sprite, northSprite
    local furniture = ISDoubleTileFurniture:new("Moonshine Still", sprite.sprite1, sprite.sprite2, sprite.northSprite1, sprite.northSprite2);
    furniture.modData["xp:Woodwork"] = 5;
    furniture.modData["need:Base.Plank"] = "6";
    furniture.modData["need:Base.Nails"] = "4";
    furniture.player = player
    furniture.completionSound = "BuildWoodenStructureLarge";
    getCell():setDrag(furniture, player);
end
