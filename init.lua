-- autogroupgui.lua
-- AutoGroup GUI for MacroQuest
-- Use /autogroupgui to toggle the window

local mq = require('mq')
local imgui = require('ImGui')

-- State variables
local showWindow = true
local shouldExit = false
local startupCommand = ""
local debugEnabled = false -- Toggled with /autogroupdebuggui

-- Color constants
local COLORS = {
    GREEN = {0.2, 0.6, 0.2, 1.0},
    GREEN_HOVER = {0.3, 0.7, 0.3, 1.0},
    GREEN_ACTIVE = {0.1, 0.5, 0.1, 1.0},
    RED = {0.6, 0.2, 0.2, 1.0},
    RED_HOVER = {0.7, 0.3, 0.3, 1.0},
    RED_ACTIVE = {0.5, 0.1, 0.1, 1.0},
    BLUE = {0.2, 0.4, 0.8, 1.0},
    BLUE_HOVER = {0.3, 0.5, 0.9, 1.0},
    BLUE_ACTIVE = {0.1, 0.3, 0.7, 1.0}
}

-- Set button colors
local function setButtonColors(colorSet)
    imgui.PushStyleColor(ImGuiCol.Button, unpack(colorSet, 1, 4))
    imgui.PushStyleColor(ImGuiCol.ButtonHovered, unpack(colorSet, 5, 8))
    imgui.PushStyleColor(ImGuiCol.ButtonActive, unpack(colorSet, 9, 12))
end

-- Create a row of centered buttons
local function createCenteredButtonRow(buttons, buttonWidth, windowWidth)
    local spacing = imgui.GetStyle().ItemSpacing.x
    local totalWidth = (buttonWidth * #buttons) + (spacing * (#buttons - 1))
    local startX = (windowWidth - totalWidth) / 2
    imgui.SetCursorPosX(startX)

    for i, button in ipairs(buttons) do
        if button.color then
            local color = COLORS[string.upper(button.color)]
            local hover = COLORS[string.upper(button.color .. "_HOVER")]
            local active = COLORS[string.upper(button.color .. "_ACTIVE")]
            setButtonColors({color[1], color[2], color[3], color[4], hover[1], hover[2], hover[3], hover[4], active[1], active[2], active[3], active[4]})
        end

        if imgui.Button(button.text, buttonWidth, button.height or 22) then
            if button.command then mq.cmd(button.command)
            elseif button.action then button.action() end
        end

        if imgui.IsItemHovered() and button.tooltip then
            imgui.SetTooltip(button.tooltip)
        end

        if button.color then imgui.PopStyleColor(3) end
        if i < #buttons then imgui.SameLine() end
    end
end

-- Draw the GUI
local function drawGUI()
    if not showWindow then return end

    local open
    open, showWindow = imgui.Begin('AutoGroup Controller', showWindow, ImGuiWindowFlags.AlwaysAutoResize)
    if not open then return end

    local windowWidth = imgui.GetWindowWidth()

    imgui.TextColored(0.4, 0.7, 1.0, 1.0, "Group Management")
    imgui.Separator()
    imgui.Spacing()

    createCenteredButtonRow({
        {text = "Create Group", command = "/autogroup create", tooltip = "/autogroup create", color = "green"},
        {text = "Status", command = "/autogroup status", tooltip = "/autogroup status", color = "blue"},
        {text = "Delete Group", command = "/autogroup delete", tooltip = "/autogroup delete", color = "red"}
    }, 93, windowWidth)

    imgui.Spacing()
    imgui.Spacing()

    imgui.TextColored(0.8, 0.4, 0.8, 1.0, "Player Management")
    imgui.Separator()
    imgui.Spacing()

    createCenteredButtonRow({
        {text = "+ Player", command = "/autogroup add player", tooltip = "/autogroup add player", color = "green"},
        {text = "+ Merc", command = "/autogroup add merc", tooltip = "/autogroup add merc", color = "green"},
        {text = "+ DanNet", command = "/autogroup add dannet", tooltip = "/autogroup add dannet", color = "green"},
        {text = "+ EQBC", command = "/autogroup add eqbc", tooltip = "/autogroup add eqbc", color = "green"}
    }, 70, windowWidth)

    createCenteredButtonRow({
        {text = "- Player", command = "/autogroup remove player", tooltip = "/autogroup remove player", color = "red"},
        {text = "- Merc", command = "/autogroup remove merc", tooltip = "/autogroup remove merc", color = "red"},
        {text = "- DanNet", command = "/autogroup remove dannet", tooltip = "/autogroup remove dannet", color = "red"},
        {text = "- EQBC", command = "/autogroup remove eqbc", tooltip = "/autogroup remove eqbc", color = "red"}
    }, 70, windowWidth)

    imgui.Spacing()

    imgui.TextColored(1.0, 0.8, 0.2, 1.0, "Merc Handler:")
    imgui.SameLine()
    imgui.SetCursorPosX(imgui.GetCursorPosX() + 10)

    for i, button in ipairs({
        {text = "ON", command = "/autogroup handlemerc on", tooltip = "/autogroup handlemerc on", color = "green", height = 18},
        {text = "OFF", command = "/autogroup handlemerc off", tooltip = "/autogroup handlemerc off", color = "red", height = 18}
    }) do
        local color = COLORS[string.upper(button.color)]
        local hover = COLORS[string.upper(button.color .. "_HOVER")]
        local active = COLORS[string.upper(button.color .. "_ACTIVE")]
        setButtonColors({color[1], color[2], color[3], color[4], hover[1], hover[2], hover[3], hover[4], active[1], active[2], active[3], active[4]})

        if imgui.Button(button.text, 40, button.height) then mq.cmd(button.command) end
        if imgui.IsItemHovered() then imgui.SetTooltip(button.tooltip) end
        imgui.PopStyleColor(3)
        if i < 2 then imgui.SameLine() end
    end

    imgui.Spacing()
    imgui.Spacing()

    imgui.TextColored(1.0, 0.6, 0.2, 1.0, "Player Roles")
    imgui.Separator()
    imgui.Spacing()

    createCenteredButtonRow({
        {text = "Main Tank", command = "/autogroup set maintank", tooltip = "/autogroup set maintank"},
        {text = "Main Assist", command = "/autogroup set mainassist", tooltip = "/autogroup set mainassist"},
        {text = "Puller", command = "/autogroup set puller", tooltip = "/autogroup set puller"}
    }, 93, windowWidth)

    createCenteredButtonRow({
        {text = "Mark NPC", command = "/autogroup set marknpc", tooltip = "/autogroup set marknpc"},
        {text = "Master Looter", command = "/autogroup set masterlooter", tooltip = "/autogroup set masterlooter"},
        {text = "Group Leader", command = "/autogroup set leader", tooltip = "/autogroup set leader"}
    }, 93, windowWidth)

    imgui.Spacing()
    imgui.Spacing()

    imgui.TextColored(0.6, 0.2, 1.0, 1.0, "Startup Command")
    imgui.Separator()
    imgui.Spacing()

    imgui.SetNextItemWidth(windowWidth - 20)
    local changed
    startupCommand, changed = imgui.InputText("##StartupInput", startupCommand)

    imgui.Spacing()

    local spacing = imgui.GetStyle().ItemSpacing.x
    local controlButtons = {
        {text = "Set Startup Cmd", width = 120, action = function()
            local cmd = tostring(startupCommand or "")
            local fullCommand = string.format('/autogroup startcommand "%s"', cmd)
            if debugEnabled then
                print('AutoGroup GUI: Sending startup command: ' .. fullCommand)
                print('AutoGroup GUI: Input was: [' .. cmd .. ']')
            end
            mq.cmd(fullCommand)
        end, tooltip = "Example: /autogroup startcommand \"/mac kissassist\"\n\n" ..
                      "WARNING: If text field is empty, this will clear\n" ..
                      "the existing startup command from the INI file!"},
        {text = "Help", width = 70, command = "/autogroup help", tooltip = "/autogroup help"},
        {text = "Exit Script", width = 70, action = function() shouldExit = true end, tooltip = "Close AutoGroup GUI", color = "red"}
    }

    local totalWidth = controlButtons[1].width + controlButtons[2].width + controlButtons[3].width + (spacing * 2)
    local startX = (windowWidth - totalWidth) / 2
    imgui.SetCursorPosX(startX)

    for i, button in ipairs(controlButtons) do
        if button.color == "red" then
            setButtonColors({
                COLORS.RED[1], COLORS.RED[2], COLORS.RED[3], COLORS.RED[4],
                COLORS.RED_HOVER[1], COLORS.RED_HOVER[2], COLORS.RED_HOVER[3], COLORS.RED_HOVER[4],
                COLORS.RED_ACTIVE[1], COLORS.RED_ACTIVE[2], COLORS.RED_ACTIVE[3], COLORS.RED_ACTIVE[4]
            })
        end

        if imgui.Button(button.text, button.width, 20) then
            if button.command then mq.cmd(button.command)
            elseif button.action then button.action() end
        end

        if imgui.IsItemHovered() and button.tooltip then
            imgui.SetTooltip(button.tooltip)
        end

        if button.color then imgui.PopStyleColor(3) end
        if i < #controlButtons then imgui.SameLine() end
    end

    if debugEnabled then
        imgui.Spacing()
        imgui.TextColored(1.0, 0.2, 0.2, 1.0, "[Debug Mode Enabled]")
    end

    imgui.Spacing()
    imgui.End()
end

-- Register GUI
mq.imgui.init('AutoGroupGUI', drawGUI)

-- Main toggle command
mq.bind('/autogroupgui', function()
    if not mq.TLO.Plugin("MQ2AutoGroup").IsLoaded() then
        print("Warning: MQ2AutoGroup plugin is not loaded.")
    end
    showWindow = not showWindow
    print('AutoGroup GUI ' .. (showWindow and 'shown' or 'hidden'))
end)

-- Hidden debug toggle
mq.bind('/autogroupdebuggui', function()
    debugEnabled = not debugEnabled
    if debugEnabled then
        print("AutoGroup GUI debug mode enabled")
    end
end)

print('AutoGroup GUI loaded. Use /autogroupgui to open.')
print('Ensure MQ2AutoGroup plugin is loaded before use.')

-- Script main loop
while not shouldExit do
    mq.delay(50)
end

print('AutoGroup GUI script exiting.')

