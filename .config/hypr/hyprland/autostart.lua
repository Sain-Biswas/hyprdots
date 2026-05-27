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
