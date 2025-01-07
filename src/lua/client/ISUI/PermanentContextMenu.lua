--
-- Copyright (c) 2023 outdead.
-- Use of this source code is governed by the MIT license
-- that can be found in the LICENSE file.
--

require 'PermanentRecipes'

-- PermanentContextMenu is the game context menu extender.
PermanentContextMenu = {}

PermanentContextMenu.ghs = " <RGB:" .. getCore():getGoodHighlitedColor():getR() .. "," .. getCore():getGoodHighlitedColor():getG() .. "," .. getCore():getGoodHighlitedColor():getB() .. "> "
PermanentContextMenu.bhs = " <RGB:" .. getCore():getBadHighlitedColor():getR() .. "," .. getCore():getBadHighlitedColor():getG() .. "," .. getCore():getBadHighlitedColor():getB() .. "> "

-- doContextMenu adds the "ContextMenu_Moonshine" item to the context menu.
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
    local sprite = object:getSprite()

    if character:getVehicle() then
        return true
    end

    local isMoonshineStill

    if sprite and sprite:getName() then
        local spriteName = sprite:getName()

        isMoonshineStill = spriteName == "MoonshineStill_0" or spriteName == "MoonshineStill_1" or
                spriteName == "MoonshineStill_2" or spriteName == "MoonshineStill_3"
    end

    if isMoonshineStill and (SandboxVars.Permanent.AllowBrewingVanillaAlcohol or SandboxVars.Permanent.AllowBrewingExclusiveAlcohol) then
        local distilOption = context:addOption(getText("ContextMenu_DistillAlcohol"), worldobjects, nil);
        local distilMenu = ISContextMenu:getNew(context);
        context:addSubMenu(distilOption, distilMenu);

        if SandboxVars.Permanent.AllowBrewingVanillaAlcohol then
            for _, recipe in pairs(PermanentRecipes.Recipes.Vanilla) do
                PermanentContextMenu.AddBrewOption(distilMenu, character, object, recipe)
            end
        end

        if SandboxVars.Permanent.AllowBrewingExclusiveAlcohol then
            local distilExclusiveOption = distilMenu:addOption(getText("ContextMenu_DistillExclusiveAlcohol"), worldobjects, nil);
            local distilExclusiveMenu = ISContextMenu:getNew(context);
            context:addSubMenu(distilExclusiveOption, distilExclusiveMenu);

            for _, recipe in pairs(PermanentRecipes.Recipes.Exclusive) do
                PermanentContextMenu.AddBrewOption(distilExclusiveMenu, character, object, recipe)
            end
        end
    end

    return true
end

PermanentContextMenu.AddBrewOption = function(distilMenu, character, object, recipe)
    local isRecipeAllowed = (recipe.type == "Vanilla" and SandboxVars.Permanent.AllowBrewingVanillaAlcohol) or
            (recipe.type == "Exclusive" and SandboxVars.Permanent.AllowBrewingExclusiveAlcohol)

    if isRecipeAllowed and recipe.disabled ~= true then
        local optionName = getText("ContextMenu_MakeAlcohol") .. " " .. getItemNameFromFullType(recipe.result)
        local option = distilMenu:addOption(optionName, worldobjects, PermanentContextMenu.OnBrew, character, object, recipe);
        option.iconTexture = getTexture(recipe.texture);

        local toolTip = PermanentContextMenu.CreateTooltip(option, character, recipe);
        toolTip:setName(optionName);
        toolTip:setTexture(recipe.texture);
    end
end

PermanentContextMenu.AddMaterialItemToTooltip = function(character, tooltip, itemCode, neededItemsCount)
    local inventory = character:getInventory()
    local enabled = true

    local items = inventory:getAllType(itemCode)
    local itemsCount = 0

    if items then
        for i=1, items:size() do
            local itemToRemove = items:get(i-1);
            if not PermanentRecipes.IsItemBlocked(character, itemToRemove) then
                itemsCount = itemsCount + 1;
            end
        end
    end

    local color = PermanentContextMenu.ghs;
    if itemsCount < neededItemsCount then
        color = PermanentContextMenu.bhs
        enabled = false;
    end

    tooltip.description = tooltip.description .. color .. getItemNameFromFullType(itemCode) .. " " .. itemsCount .. "/" .. neededItemsCount .. " <LINE>";

    return tooltip, enabled
end

PermanentContextMenu.AddFluidItemToTooltip = function(character, tooltip, itemCode, fluid)
    local inventory = character:getInventory()
    local enabled = true

    local items = inventory:getAllType(itemCode)
    local itemsCount = 0

    if items then
        for i=1, items:size() do
            local itemToRemove = items:get(i-1);
            if not PermanentRecipes.IsItemBlocked(character, itemToRemove) and PermanentRecipes.IsFluidReady(itemToRemove, fluid) then
                itemsCount = itemsCount + 1;
            end
        end
    end

    local color = PermanentContextMenu.ghs;
    if itemsCount < 1 then
        color = PermanentContextMenu.bhs
        enabled = false;
    end

    tooltip.description = tooltip.description .. color .. getItemNameFromFullType(itemCode) .. " " .. itemsCount .. "/" .. "1" .. " <LINE>";

    return tooltip, enabled
end

PermanentContextMenu.CreateTooltip = function(option, character, recipe)
    local inventory = character:getInventory()
    local cookingSkill = character:getPerkLevel(Perks.Cooking);

    local tooltip = ISWorldObjectContextMenu.addToolTip();
    option.toolTip = tooltip;
    if recipe.type == "Vanilla" then
        tooltip.footNote = getText("Tooltip_brew_footNote")
    end

    local enabled = true;
    tooltip.description = getText("Tooltip_craft_Needs") .. ": <LINE>";

    for itemCode, neededItemsCount in pairs(recipe.usedItems) do
        tooltip, enabled = PermanentContextMenu.AddMaterialItemToTooltip(character, tooltip, itemCode, neededItemsCount)
    end

    if recipe.fluids then
        for itemCode, fluid in pairs(recipe.fluids) do
            tooltip, enabled = PermanentContextMenu.AddFluidItemToTooltip(character, tooltip, itemCode, fluid)
        end
    end

    local color = PermanentContextMenu.ghs;
    if cookingSkill < recipe.cookingSkill then
        color = PermanentContextMenu.bhs
        enabled = false;
    end

    tooltip.description = tooltip.description .. "<LINE>" .. color .. getText("IGUI_perks_Cooking") .. " " .. cookingSkill .. "/" .. recipe.cookingSkill .. " <LINE>";

    if not enabled then
        option.onSelect = nil;
        option.notAvailable = true;
    end

    tooltip.description = " " .. tooltip.description .. " ";

    return tooltip;
end

PermanentContextMenu.OnBrew = function(worldobjects, character, object, recipe)
    if ISCampingMenu.walkToCampfire(character, object:getSquare()) then
        ISTimedActionQueue.add(PermanentsBrewingAction:new(character, recipe, object));
    end
end

Events.OnFillWorldObjectContextMenu.Add(PermanentContextMenu.doContextMenu);
