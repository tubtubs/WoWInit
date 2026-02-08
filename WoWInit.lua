
--init functions
function WI_Run()
    if not (WI_Vars) then
        WI_Vars = {
            Commands = "",
            MinimapButtonPos = 320;
        };
    else
        DEFAULT_CHAT_FRAME:AddMessage(WI_Vars.Commands)
        WI_ExecuteCMDs()
    end
    DEFAULT_CHAT_FRAME:AddMessage(WI_SPLASH)
    WI_MinimapButton_UpdatePosition()
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

--Minimap Button
function WI_MinimapButton_UpdatePosition()
	WI_MinimapButtonFrame:SetPoint(
		"TOPLEFT",
		"Minimap",
		"TOPLEFT",
		52 - (80 * cos(WI_Vars.MinimapButtonPos )),
		(80 * sin(WI_Vars.MinimapButtonPos )) - 52
	);
end

function WI_MinimapButton_OnClick()
    local StartX, StartY = GetCursorPosition()

    local EndX, EndY
    if arg1 == 'LeftButton' then
        WI_CMDFrame:Show()
    elseif arg1 == 'RightButton' then
        WI_MinimapButtonFrame:SetScript('OnUpdate', function(self)
            EndX, EndY = GetCursorPosition()
            --DEFAULT_CHAT_FRAME:AddMessage(format("%s", EndX-StartX))
            WI_Vars.MinimapButtonPos = WI_Vars.MinimapButtonPos -(EndX-StartX)
            WI_MinimapButton_UpdatePosition()
            StartX, StartY = GetCursorPosition()
        end)
    end
end

function WI_MinimapButton_OnClickUp()
    WI_MinimapButtonFrame:SetScript('OnUpdate', nil)
end

--chat commands
SLASH_WOWINIT1 = "/WoWInit"
SLASH_WOWINIT2 = "/WI"

local function TextMenu(arg)
    WI_CMDFrame:Show()
end
SlashCmdList['WOWINIT'] = TextMenu
