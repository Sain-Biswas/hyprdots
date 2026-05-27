-- ░█░░░█▀█░█░█░█▀█░█░█░▀█▀░█▀▀
-- ░█░░░█▀█░░█░░█░█░█░█░░█░░▀▀█
-- ░▀▀▀░▀░▀░░▀░░▀▀▀░▀▀▀░░▀░░▀▀▀


--  Refer to https://wiki.hypr.land/Configuring/Layouts/


hl.config({

    general = {

        --  which layout to use. [dwindle/master/scrolling/monocle]
        layout = "dwindle"
    },

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
