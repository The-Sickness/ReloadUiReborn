-- Made by Sharpedge_Gaming
-- Version for 11.1.0 and 11.1.5

local function GetGameVersion()
    local version = GetBuildInfo() -- Returns "major.minor.patch.build"
    local major, minor, patch = string.match(version, "^(%d+)%.(%d+)%.(%d+)")
    return tonumber(major), tonumber(minor), tonumber(patch)
end

local function CreateGameMenuButton()
    local button = CreateFrame("Button", "GameMenuButtonReloadButton", GameMenuFrame, "GameMenuButtonTemplate")
    button:SetText("Reload UI")
    button:SetSize(200, 28)
    button:SetScript("OnClick", function()
        PlaySound(SOUNDKIT.IG_MAINMENU_LOGOUT)
        ReloadUI()
    end)
    button:GetFontString():SetFont(STANDARD_TEXT_FONT, 15)
    
    local major, minor, patch = GetGameVersion()
    GameMenuFrame:HookScript("OnShow", function()
        GameMenuFrame:SetHeight(GameMenuFrame:GetHeight() + 25)
        
        if GameMenuButtonLogout then
            button:SetPoint("TOPLEFT", GameMenuFrame, "TOPLEFT", 28, -279)
            GameMenuButtonLogout:ClearAllPoints()
            GameMenuButtonLogout:SetPoint("TOP", button, "BOTTOM", 0, -1)
        else
            if major == 11 and minor == 1 and patch == 0 then
                button:SetPoint("TOPLEFT", GameMenuFrame, "TOPLEFT", 28, -280) -- 11.1.0 behavior
            else
                button:SetPoint("TOPLEFT", GameMenuFrame, "TOPLEFT", 28, -315) -- All other versions behavior
            end
        end
    end)
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
end

local eventFrame = CreateFrame("Frame")
eventFrame:RegisterEvent("ADDON_LOADED")
eventFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "ReloadUI" then
        C_Timer.After(0.1, InitializeButtons)
        self:UnregisterEvent("ADDON_LOADED")
    end
end)

































