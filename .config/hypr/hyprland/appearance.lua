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
        gaps_out = 8,

        --  size of the border around windows
        border_size = 1,

        col = {
            --  border color for the active window
            active_border = { colors = { colors.primary, colors.error }, angle = 45 },
            --  border color for inactive windows
            inactive_border = colors.outline,
        },

        --  enables resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,
    },

    --  See, https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
    decoration = {

        --  rounded corners’ radius (in layout px)
        rounding = 10,
        --  adjusts the curve used for rounding corners, larger is smoother, 2.0 is a circle, 4.0 is a squircle, 1.0 is a triangular corner. [1.0 - 10.0]
        rounding_power = 15,

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
            size = 2,
            --  the amount of passes to perform
            passes = 5,

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
