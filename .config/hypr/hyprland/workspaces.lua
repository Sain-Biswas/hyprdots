-- ░█░█░▀█▀░█▀█░█▀▄░█▀█░█░█░█▀▀░░░█▀█░█▀█░█▀▄░░░█░█░█▀█░█▀▄░█░█░█▀▀░█▀█░█▀█░█▀▀░█▀▀░█▀▀
-- ░█▄█░░█░░█░█░█░█░█░█░█▄█░▀▀█░░░█▀█░█░█░█░█░░░█▄█░█░█░█▀▄░█▀▄░▀▀█░█▀▀░█▀█░█░░░█▀▀░▀▀█
-- ░▀░▀░▀▀▀░▀░▀░▀▀░░▀▀▀░▀░▀░▀▀▀░░░▀░▀░▀░▀░▀▀░░░░▀░▀░▀▀▀░▀░▀░▀░▀░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░▀▀▀


-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.

-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ name        = "no-gaps-wtv1", match       = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding    = 0 })
-- hl.window_rule({ name        = "no-gaps-f1", match       = { float = false, workspace = "f[1]" }, border_size = 0, rounding    = 0 })





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





--  Floating Windows
hl.window_rule({
    name = "gnome-calculator-floating",
    match = {
        initial_class = "org.gnome.Calculator",
    },
    size = { 400, 600 },
    float = true,
    animation = "slide top"
})
hl.window_rule({
    name = "blueman-manager-floating",
    match = {
        initial_class = "blueman-manager"
    },
    size = { 600, 500 },
    float = true,
    animation = "slide top"
})
hl.window_rule({
    name = "waybar-nmtui-floating",
    match = {
        initial_title = "waybar-nmtui"
    },
    size = { 900, 700 },
    float = true,
    animation = "slide top"
})
hl.window_rule({
    name = "pavucontrol-floating",
    match = {
        initial_class = "org.pulseaudio.pavucontrol"
    },
    size = { 600, 500 },
    float = true,
    animation = "slide top"
})





--  Custom Window rulez
hl.layer_rule({
    name = "rofi-popup",
    match = { namespace = "rofi" },
    animation = "slide bottom",
    dim_around = true
})

hl.layer_rule({
    name = "notifications-animation",
    match = { namespace = "swaync-control-center" },
    animation = "slide top",
    dim_around = true
})
