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
