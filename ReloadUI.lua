-- ReloadUI
-- Made by Sharpedge_Gaming
-- v2.1 - 10.2.5

local function CreateGameMenuButton()
    local button = CreateFrame("Button", "GameMenuButtonReloadButton", GameMenuFrame, "GameMenuButtonTemplate")
    button:SetText("Reload UI")
    button:SetScript("OnClick", function()
        PlaySound(SOUNDKIT.IG_MAINMENU_LOGOUT)
        ReloadUI()
    end)

    if GameMenuFrame_UpdateVisibleButtons then
        hooksecurefunc("GameMenuFrame_UpdateVisibleButtons", function()
            GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + 25)
            local point, relativeTo, relativePoint, x, y = GameMenuButtonLogout:GetPoint(1)
            if relativeTo and relativeTo ~= button then
                button:SetPoint(point, relativeTo, relativePoint, x, y - 1)
            end
            GameMenuButtonLogout:ClearAllPoints()
            GameMenuButtonLogout:SetPoint("TOP", button, "BOTTOM", 0, -1)
        end)
    end
end

local function CreateGarbageCollectionButton()
    local gcButton = CreateFrame("Button", "GameMenuButtonGarbageCollection", GameMenuFrame, "GameMenuButtonTemplate")
    gcButton:SetText("Collect Garbage")
    gcButton:SetScript("OnClick", function()
        -- Measure memory usage before garbage collection
        local memoryBefore = collectgarbage("count")

        -- Perform garbage collection
        collectgarbage("collect")

        -- Measure memory usage after garbage collection
        local memoryAfter = collectgarbage("count")

        -- Calculate the difference (memory freed)
        local memoryFreed = memoryBefore - memoryAfter

        -- Play sound for feedback
        PlaySound(SOUNDKIT.IG_MAINMENU_OPTION)

        -- Print or display the amount of memory freed
        print(string.format("Garbage collection performed. Memory freed: %.2f KB", memoryFreed))
    end)
    
    -- Position the button just below the last added button
    gcButton:SetPoint("TOP", GameMenuButtonReloadButton, "BOTTOM", 0, -16)
    gcButton:SetSize(GameMenuButtonLogout:GetWidth(), GameMenuButtonLogout:GetHeight())

    -- Adjust GameMenuFrame's height to accommodate the new button
    GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + gcButton:GetHeight() + 16)
end

local function CreateSettingsPanelButton()
    local button = CreateFrame("Button", "SettingsPanelReloadUI", SettingsPanel, "UIPanelButtonTemplate")
    button:SetText("RELOAD UI")
    button:SetSize(96, 22)
    button:SetPoint("BOTTOMLEFT", SettingsPanel, "BOTTOMLEFT", 16, 16)
    button:SetScript("OnClick", function()
        PlaySound(SOUNDKIT.IG_MAINMENU_LOGOUT)
        ReloadUI()
        HideUIPanel(InterfaceOptionsFrame)
    end)
end

local function InitializeButtons()
    CreateGameMenuButton()
    CreateSettingsPanelButton()
	CreateGameMenuButton()
    CreateGarbageCollectionButton()
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "ReloadUI" then
        InitializeButtons()
        self:UnregisterEvent("ADDON_LOADED")
    end
end)




























