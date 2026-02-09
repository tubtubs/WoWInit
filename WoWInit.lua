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
local WI_Dewdrop = AceLibrary("Dewdrop-2.0");
local WI_DewdropSubMenu = AceLibrary("Dewdrop-2.0");

--init functions
function WI_Run()
    if not (WI_Vars) then
        WI_Vars = {
            Commands = "",
        };
    else
        WI_ExecuteCMDs()
    end
    WI_MinimapIconRegister()
    WI_DewdropRegister()
    DEFAULT_CHAT_FRAME:AddMessage(WI_SPLASH)
end

function WI_ExecuteCMDs()
	for w in string.gfind(WI_Vars.Commands, "([^\r\n]+)") do
        DEFAULT_CHAT_FRAME.editBox:SetText(w)
        ChatEdit_SendText(DEFAULT_CHAT_FRAME.editBox, 0)
	end
end

--Dropdown Menu Code
function WI_PasteExample(txt)
    w = WI_CMDFrame_ScrollFrame_EditBox:GetText()
    WI_CMDFrame_ScrollFrame_EditBox:SetText(w .. txt)
end

function WI_ToggleExampleMenu()
    if WI_Dewdrop:IsOpen() then
        WI_Dewdrop:Close();
    else
        WI_Dewdrop:Open(this);
    end
end

function WI_DewdropRegister()
	WI_Dewdrop:Register(WI_CMDFrame_ExamplesButton, --Bound Frame
		'point', function(parent) --Point
			return "TOP", "BOTTOM"
		end,
		'children', function(level, value) --Children
			if level == 1 then
                for i,j in ipairs(WI_EXAMPLES) do
                    if j.check() then
                        WI_Dewdrop:AddLine(
                            'text', j.name,
                            'tooltipTitle', j.name,
                            'tooltipText', j.tooltip,  
                            'textR', 1,
                            'textG', 0.82,
                            'textB', 0,
                            'func', WI_PasteExample,
                            'arg1', j.example,
                            'notCheckable', true
                        )
                    end
                end

				--Close button
				WI_Dewdrop:AddLine(
					'text', "Close Menu",
					'textR', 0,
					'textG', 1,
					'textB', 1,
					'func', function() WI_Dewdrop:Close() end,
					'notCheckable', true
				)
			end
		end,
		'dontHook', true
	)
end

--Minimap Button Setup
function WI_MinimapIconRegister()
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
end

--Command Entry Frame
function WI_CMDFrame_SubmitButton_OnClick()
    WI_Vars.Commands = WI_CMDFrame_ScrollFrame_EditBox:GetText()
    WI_CMDFrame:Hide()
end

function WI_CMDFrame_OnShow()
    WI_CMDFrame_ScrollFrame_EditBox:SetText(WI_Vars.Commands)
    WI_CMDFrame_ScrollFrame_EditBox:SetFocus()
    local max
    _, max =  WI_CMDFrame_ScrollFrameScrollBar:GetMinMaxValues();
    WI_CMDFrame_ScrollFrameScrollBar:SetValue(max);
    WI_CMDFrame_SubmitButton_Update()
end

function WI_CMDFrame_OnHide()
    WI_Dewdrop:Close(1)
end

function WI_CMDFrame_SubmitButton_Update()
    w = WI_CMDFrame_ScrollFrame_EditBox:GetText()
    if w == "" or w==WI_Vars.Commands then
        WI_CMDFrame_SubmitButton:Disable()
    else
        WI_CMDFrame_SubmitButton:Enable()
    end
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
