WI_ADDONNAME = "WoWInit"
WI_AUTHOR = "Tubtubs"
WI_VERSION = "1.0"
WI_FULLNAME = WI_ADDONNAME .. " v" .. WI_VERSION .. " by " .. WI_AUTHOR
WI_SPLASH = WI_FULLNAME .. " loaded." 

WI_CMDFrameTitle = WI_ADDONNAME
WI_SUBMITBUTTON = "Save"
WI_EXAMPLESBUTTON = "Examples"
WI_CANCELBUTTON = "Cancel"
WI_HELPTEXT = "Enter the macro you'd like to run on startup below.\nClick Examples to paste in some common macros."

WI_EXAMPLES = 
-- name     - title of the button, and tooltip
-- tooltip  - the text that displays on the tooltip, under the tooltip title
-- example  - the command to paste into the command box. Usually prepended with newline
-- check    - returns if the example should be included. 
--          Ex: returns false if the relevant addon isn't installed, or just returns true
{
    {
        name = "Console Print",
        tooltip = "Prints Test to the chat frame",
        example = "\n/run DEFAULT_CHAT_FRAME:AddMessage(\"Test\")",
        check = function() 
            return true
        end,
    },
    {
        name = "MorphHelper",
        tooltip = "Morphs the player into a murloc",
        example = "\n/mh morph player 31",
        check = function() 
            if (MH_Vars) then
                return true
            else
                return false
            end
        end,
    },
    {
        name = "pfQuest",
        tooltip = "Tracks chests, rares and closes the map if it opens",
        example = "\n/db track chests\n/db track rares\n/run if WorldMapFrame:IsShown() then ToggleWorldMap() end",
        check = function() 
            if (pfQuest) then
                return true
            else
                return false
            end
        end,
    },
    {
        name = "Print Rested",
        tooltip = "Prints rested XP % in chat",
        example = "\n/script local r = GetXPExhaustion() if r then DEFAULT_CHAT_FRAME:AddMessage(\"Rested XP: \" .. tostring(math.floor((r / UnitXPMax(\"player\")) * 100)) .. \"%\") else DEFAULT_CHAT_FRAME:AddMessage(\"No Rested XP.\") end",
        check = function() 
            return true
        end,
    },
}