-- ░█░█░█▀▀░█░█░█▀▄░▀█▀░█▀█░█▀▄░▀█▀░█▀█░█▀▀░█▀▀
-- ░█▀▄░█▀▀░░█░░█▀▄░░█░░█░█░█░█░░█░░█░█░█░█░▀▀█
-- ░▀░▀░▀▀▀░░▀░░▀▀░░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀


--  Refer to https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod = "SUPER"                            --  Sets "Windows" key as the main modifier key
local scripts = "~/hyprdots/.config/hypr/scripts/" --  Scripts directory


--  Application Launching KeyBindings
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("uwsm app -- alacritty"))             --  Open the primary terminal
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("uwsm app -- ghostty"))       --  Open the secondary terminal

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- nautilus"))                   --  Open Gnome File Explorer

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm app -- zen-browser"))                --  Open Zen Browser
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("uwsm app -- vivaldi-stable"))     --  Open Vivaldi Browser
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("uwsm app -- google-chrome-stable")) --  Open Chrome Browser


--  System KeyBindings
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(scripts .. "open-rofi-menu.sh app"))        --  Open Rofi Application Menu
hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd(scripts .. "open-rofi-menu.sh emoji")) --  Open Rofi Emoji Selector
hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(scripts .. "open-rofi-menu.sh window"))   --  Open Rofi menu for opened application window

hl.bind(mainMod .. " + Backspace", hl.dsp.exec_cmd(scripts .. "rofi-power-menu.sh"))   --  Open Rofi Power menu
-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(utility .. "/utility-clipboard"))                                        --  Open Cliphist Clipboard manager using Rofi

hl.bind(mainMod .. " + Q", hl.dsp.window.close())                                                                   --  Close currently active window
hl.bind(mainMod .. " + Delete",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")) --  Kill the active Hyprland session

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())                                                              --  Toggle the currently active window between Fullscreen and tilled
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))                                      --  Toggle currently active window between tilled and floating state
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())                                                                  --  dwindle only
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))                                                            -- dwindle only


--  Misc.
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(scripts .. "refresh-theme.sh")) --  Refresh currently applied color scheme


-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))


for i = 1, 10 do
    local key = i % 10                                                              -- 10 maps to key 0

    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))               -- Switch workspaces with mainMod + [0-9]

    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i })) -- Move active window to a workspace with mainMod + SHIFT + [0-9]
end


-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))


-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))


-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- Laptop multimedia keys for volume and LCD brightness
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1.55 @DEFAULT_AUDIO_SINK@ 5%+"),
    { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
    { locked = true, repeating = true })

hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
    { locked = true, repeating = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
    { locked = true, repeating = true })

hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 1%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 1%-"), { locked = true, repeating = true })


-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true, long_press = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl position 5+"), { locked = true })

hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })

hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true, long_press = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl position 5-"), { locked = true })
