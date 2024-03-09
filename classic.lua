
local function CreateClassicGameMenuButton()
    local button = CreateFrame("Button", "GameMenuButtonReloadButton", GameMenuFrame, "GameMenuButtonTemplate")
    button:SetText("Reload UI")
    button:SetScript("OnClick", function()
        PlaySound("igMainMenuLogout")
        ReloadUI()
    end)

    -- Adjust the game menu to accommodate the new button
    if GameMenuFrame_UpdateVisibleButtons then
        hooksecurefunc("GameMenuFrame_UpdateVisibleButtons", function()
            GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + 25)
            local point, relativeTo, relativePoint, x, y = GameMenuButtonLogout:GetPoint()
            if relativeTo and relativeTo ~= button then
                button:SetPoint(point, relativeTo, relativePoint, x, y - 1)
            end
            GameMenuButtonLogout:ClearAllPoints()
            GameMenuButtonLogout:SetPoint("TOP", button, "BOTTOM", 0, -1)
        end)
    end
end

-- Create the Reload UI button in the interface options for WoW Classic
local function CreateInterfaceOptionsButton()
    local button = CreateFrame("Button", "InterfaceOptionsFrameReloadUI", InterfaceOptionsFrame, "UIPanelButtonTemplate")
    button:SetText("RELOAD UI")
    button:SetSize(96, 22)
    -- Adjust position relative to another button (e.g., the Defaults button)
    button:SetPoint("BOTTOMLEFT", InterfaceOptionsFrameDefaults, "BOTTOMRIGHT", 16, 16)
    button:SetScript("OnClick", function()
        PlaySound("igMainMenuLogout")
        ReloadUI()
        HideUIPanel(InterfaceOptionsFrame)
    end)
end

-- Initialize the buttons when the addon is loaded
local function InitializeClassicButtons()
    CreateClassicGameMenuButton()
    CreateInterfaceOptionsButton()
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "ReloadUI" then
        InitializeClassicButtons()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)
