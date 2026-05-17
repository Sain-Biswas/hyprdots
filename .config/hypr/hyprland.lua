-- ░█░█░█░█░█▀█░█▀▄░█░░░█▀█░█▀█░█▀▄░░░█▀▀░█▀█░█▀█░█▀▀░▀█▀░█▀▀░█░█░█▀▄░█▀█░▀█▀░▀█▀░█▀█░█▀█
-- ░█▀█░░█░░█▀▀░█▀▄░█░░░█▀█░█░█░█░█░░░█░░░█░█░█░█░█▀▀░░█░░█░█░█░█░█▀▄░█▀█░░█░░░█░░█░█░█░█
-- ░▀░▀░░▀░░▀░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀░░░░▀▀▀░▀▀▀░▀░▀░▀░░░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀


-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


-- ░█▄█░█▀█░█▀█░▀█▀░▀█▀░█▀█░█▀▄░█▀▀
-- ░█░█░█░█░█░█░░█░░░█░░█░█░█▀▄░▀▀█
-- ░▀░▀░▀▀▀░▀░▀░▀▀▀░░▀░░▀▀▀░▀░▀░▀▀▀


-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})





-- ░█▀█░█░█░▀█▀░█▀█░█▀▀░▀█▀░█▀█░█▀▄░▀█▀
-- ░█▀█░█░█░░█░░█░█░▀▀█░░█░░█▀█░█▀▄░░█░
-- ░▀░▀░▀▀▀░░▀░░▀▀▀░▀▀▀░░▀░░▀░▀░▀░▀░░▀░


-- See https://wiki.hypr.land/Configuring/Basics/Autostart/


--  Autostart necessary processes (like notifications daemons, status bars, etc.)
--  Or execute your favorite apps at launch.

hl.on("hyprland.start", function()
    --  start awww daemon for wallpaper display
    hl.exec_cmd("uwsm app -- awww-daemon")

    --  start polkit authentication agent for sudo access permission escalation
    hl.exec_cmd("uwsm app --  /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

    -- start cliphist to record contents that are copied to clipboard
    hl.exec_cmd("uwsm app -- wl-paste --type text --watch cliphist store")
    hl.exec_cmd("uwsm app -- wl-paste --type image --watch cliphist store")

    --  clear clipboard entires from last session
    hl.exec_cmd("cliphist wipe")
end)





-- ░█▀█░█▀▀░█▀▄░█▄█░▀█▀░█▀▀░█▀▀░▀█▀░█▀█░█▀█░█▀▀
-- ░█▀▀░█▀▀░█▀▄░█░█░░█░░▀▀█░▀▀█░░█░░█░█░█░█░▀▀█
-- ░▀░░░▀▀▀░▀░▀░▀░▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░▀░▀▀▀


-- Refer to https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/

-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

hl.config({

    --  See, https://wiki.hypr.land/Configuring/Basics/Variables/#ecosystem
    ecosystem = {

        --  whether to enable permission control.
        enforce_permissions = true,
    },
})


--  Grim (Screenshot Utility)
hl.permission({
    binary = "/usr/bin/grim",
    type = "screencopy",
    mode = "allow",
})

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")





-- ░█▀█░█▀█░█▀█░█▀▀░█▀█░█▀▄░█▀█░█▀█░█▀▀░█▀▀
-- ░█▀█░█▀▀░█▀▀░█▀▀░█▀█░█▀▄░█▀█░█░█░█░░░█▀▀
-- ░▀░▀░▀░░░▀░░░▀▀▀░▀░▀░▀░▀░▀░▀░▀░▀░▀▀▀░▀▀▀


local colors = require("common.colors")


-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/


hl.config({

    --  See, https://wiki.hypr.land/Configuring/Basics/Variables/#general
    general = {

        --  gaps between windows
        gaps_in = 5,
        --  gaps between windows and monitor edges
        gaps_out = 5,

        --  size of the border around windows
        border_size = 4,

        col = {
            --  border color for the active window
            active_border = { colors = { colors.primary, colors.error }, angle = 45 },
            --  border color for inactive windows
            inactive_border = colors.outline,
        },

        --  enables resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        --  which layout to use. [dwindle/master/scrolling/monocle]
        layout = "dwindle"
    },

    --  See, https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
    decoration = {

        --  rounded corners’ radius (in layout px)
        rounding = 10,
        --  adjusts the curve used for rounding corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner. [1.0 - 10.0]
        rounding_power = 2,

        --  opacity of active windows. [0.0 - 1.0]
        active_opacity = 1.0,
        --  opacity of inactive windows. [0.0 - 1.0]
        inactive_opacity = 1.0,

        --  See, https://wiki.hypr.land/Configuring/Basics/Variables/#shadow
        shadow = {

            --  enable drop shadows on windows
            enabled = true,
            --  Shadow range (“size”) in layout px
            range = 4,
            --  in what power to render the falloff (more power, the faster the falloff) [1 - 4]
            render_power = 3,
            --  shadow’s color. Alpha dictates shadow’s opacity.
            color = colors.sourceColor
        },

        --  See, https://wiki.hypr.land/Configuring/Basics/Variables/#blur
        blur = {

            --  enable kawase window background blur
            enabled = true,
            --  blur size (distance)
            size = 5,
            --  the amount of passes to perform
            passes = 3,

            --  Increase saturation of blurred colors. [0.0 - 1.0]
            vibrancy = 0.1696
        }
    },

    --  See, https://wiki.hypr.land/Configuring/Basics/Variables/#misc
    misc = {

        --  Enforce any of the 3 default wallpapers. Setting this to 0 or 1 disables the anime background. -1 means “random”. [-1/0/1/2]
        force_default_wallpaper = 0,
        --  disables the random Hyprland logo / anime girl background. :(
        disable_hyprland_logo   = true,
    },
})





-- ░█▀█░█▀█░▀█▀░█▄█░█▀█░▀█▀░▀█▀░█▀█░█▀█░█▀▀
-- ░█▀█░█░█░░█░░█░█░█▀█░░█░░░█░░█░█░█░█░▀▀█
-- ░▀░▀░▀░▀░▀▀▀░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀░▀▀▀


--  Refer to https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/


--  See, https://wiki.hypr.land/Configuring/Basics/Variables/#animations
hl.config({
    animations = {
        enabled = true,
    }
})

--  Default bezier curves and animations
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

--  Default spring animations
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

--  Animation declaration
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })






-- ░█░░░█▀█░█░█░█▀█░█░█░▀█▀░█▀▀
-- ░█░░░█▀█░░█░░█░█░█░█░░█░░▀▀█
-- ░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░░▀░░▀▀▀


--  Refer to https://wiki.hypr.land/Configuring/Layouts/


hl.config({

    --  See, https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
    dwindle = {

        --  if enabled, the split (side/top) will not change regardless of what happens to the container.
        preserve_split = true
    },

    --  See, https://wiki.hypr.land/Configuring/Layouts/Master-Layout/
    master = {

        --  "master" : new window becomes master;
        --  "slave"  : new windows are added to slave stack;
        --  "inherit": inherit from focused window
        new_status = "master"
    },

    --  See, https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
    scrolling = {

        --  when enabled, a single column on a workspace will always span the entire screen.
        fullscreen_on_one_column = true,
    },
})







-- ░▀█▀░█▀█░█▀█░█░█░▀█▀░█▀▀
-- ░░█░░█░█░█▀▀░█░█░░█░░▀▀█
-- ░▀▀▀░▀░▀░▀░░░▀▀▀░░▀░░▀▀▀


--  Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({

    --  See, https://wiki.hypr.land/Configuring/Basics/Variables/#input
    input = {

        --  Appropriate XKB keymap parameter
        kb_layout = "us",

        --  Engage numlock by default.
        numlock_by_default = true,

        --  Specify if and how cursor movement should affect window focus. See the note below. [0/1/2/3]
        follow_mouse = true,

        --  Sets the mouse input sensitivity. Value is clamped to the range -1.0 to 1.0.
        sensitivity = 0,

        --  See, https://wiki.hypr.land/Configuring/Basics/Variables/#touchpad
        touchpad = {

            --  Inverts scrolling direction. When enabled, scrolling moves content directly, rather than manipulating a scrollbar.
            natural_scroll = true
        }
    }
})


--  Refer to https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})


-- Refer to https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})





-- ░█░█░█▀▀░█░█░█▀▄░▀█▀░█▀█░█▀▄░▀█▀░█▀█░█▀▀░█▀▀
-- ░█▀▄░█▀▀░░█░░█▀▄░░█░░█░█░█░█░░█░░█░█░█░█░▀▀█
-- ░▀░▀░▀▀▀░░▀░░▀▀░░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀


--  Refer to https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod = "SUPER" --  Sets "Windows" key as the main modifier key


--  Application Launching KeyBindings
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("uwsm app -- alacritty"))             --  Open the primary terminal
hl.bind(mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd("uwsm app -- ghostty"))       --  Open the secondary terminal

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("uwsm app -- nautilus"))                   --  Open Gnome File Explorer

hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("uwsm app -- zen-browser"))                --  Open Zen Browser
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("uwsm app -- vivaldi-stable"))     --  Open Vivaldi Browser
hl.bind(mainMod .. " + ALT + B", hl.dsp.exec_cmd("uwsm app -- google-chrome-stable")) --  Open Chrome Browser


--  System KeyBindings
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("rofi -show drun -show-icons")) --  Open Rofi Application Menu
-- hl.bind(mainMod .. " + Period", hl.dsp.exec_cmd(utility .. "/utility-rofi emoji"))                                  --  Open Rofi Emoji Selector
-- hl.bind(mainMod .. " + Tab", hl.dsp.exec_cmd(utility .. "/utility-rofi window"))                                    --  Open Rofi menu for opened application window

-- hl.bind(mainMod .. " + Backspace", hl.dsp.exec_cmd(utility .. "/utility-power-menu"))                               --  Open Rofi Power menu
-- hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(utility .. "/utility-clipboard"))                                        --  Open Cliphist Clipboard manager using Rofi

hl.bind(mainMod .. " + Q", hl.dsp.window.close())                                                                   --  Close currently active window
hl.bind(mainMod .. " + Delete",
    hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'")) --  Kill the active Hyprland session

hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())                                                              --  Toggle the currently active window between Fullscreen and tilled
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))                                      --  Toggle currently active window between tilled and floating state
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())                                                                  --  dwindle only
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))                                                            -- dwindle only


--  Misc.
-- hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(utility .. "/utility-refresh-theme")) --  Refresh currently applied color scheme


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





-- ░█░█░▀█▀░█▀█░█▀▄░█▀█░█░█░█▀▀░░░█▀█░█▀█░█▀▄░░░█░█░█▀█░█▀▄░█░█░█▀▀░█▀█░█▀█░█▀▀░█▀▀░█▀▀
-- ░█▄█░░█░░█░█░█░█░█░█░█▄█░▀▀█░░░█▀█░█░█░█░█░░░█▄█░█░█░█▀▄░█▀▄░▀▀█░█▀▀░█▀█░█░░░█▀▀░▀▀█
-- ░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀░░░▀░▀░▀░▀░▀▀░░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░▀▀▀


-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.

-- hl.workspace_rule({
--     workspace = "w[tv1]",
--     gaps_out = 0,
--     gaps_in = 0,
-- })

-- hl.workspace_rule({
--     workspace = "f[1]",
--     gaps_out = 0,
--     gaps_in = 0,
-- })

-- hl.window_rule({
--     name        = "no-gaps-wtv1",

--     match       = {
--         float = false,
--         workspace = "w[tv1]",
--     },

--     border_size = 0,
--     rounding    = 0,
-- })

-- hl.window_rule({
--     name        = "no-gaps-f1",

--     match       = {
--         float = false,
--         workspace = "f[1]",
--     },

--     border_size = 0,
--     rounding    = 0,
-- })





--  See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
--  and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

--  Example window rules that are useful

local suppressMaximizeRule = hl.window_rule({

    --  Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({

    --  Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",

    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})


--  Layer rules also return a handle.
--
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)


--  Hyprland-run windowrule

hl.window_rule({
    name  = "move-hyprland-run",

    match = {
        class = "hyprland-run",
    },

    move  = "20 monitor_h-120",
    float = true,
})
