--[[
** WoWInit **
by Tubtubs
Setup commands to run after you login to WoW. Type /wi, or click the minimap to access the editor.
Includes presets for:
pfQuest
morphHelper

]]--
local libIcon = LibStub("LibDBIcon-1.0");
local libData = LibStub("LibDataBroker-1.1");


--init functions
function WI_Run()
    if not (WI_Vars) then
        WI_Vars = {
            Commands = "",
        };
    else
        DEFAULT_CHAT_FRAME:AddMessage(WI_Vars.Commands)
        WI_ExecuteCMDs()
    end
    local iconData = libData:NewDataObject("WoWInit icon data", {
        OnClick = function()
            if WI_CMDFrame:IsShown() then
                PlaySound("igMainMenuContinue");
                WI_CMDFrame:Hide();
            else
                PlaySound("igMainMenuOpen");
                WI_CMDFrame:Show();
            end
        end,
        OnTooltipShow = function(tooltip)
            tooltip:SetText(WI_ADDONNAME);
        end,
        icon = "Interface\\Icons\\INV_Misc_PunchCards_Blue"
    });

    libIcon:Register("WoWInit icon", iconData, WoWInit_Icon);
    DEFAULT_CHAT_FRAME:AddMessage(WI_SPLASH)
end

function WI_ExecuteCMDs()
	for w in string.gfind(WI_Vars.Commands, "([^\r\n]+)") do
        DEFAULT_CHAT_FRAME.editBox:SetText(w)
        ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
	end
end

--Command Entry Frame
function WI_CMDFrame_SubmitButton_OnClick()
    WI_Vars.Commands = WI_CMDFrame_ScrollFrame_EditBox:GetText()
    WI_CMDFrame:Hide();
end

function WI_CMDFrame_OnShow()
    WI_CMDFrame_ScrollFrame_EditBox:SetText(WI_Vars.Commands)
end

--chat commands
SLASH_WOWINIT1 = "/WoWInit"
SLASH_WOWINIT2 = "/WI"

local function TextMenu(arg)
    if WI_CMDFrame:IsShown() then
        PlaySound("igMainMenuContinue");
        WI_CMDFrame:Hide();
    else
        PlaySound("igMainMenuOpen");
        WI_CMDFrame:Show();
    end
end
SlashCmdList['WOWINIT'] = TextMenu
