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

--  wayfreeze (Screenshot Utility)
hl.permission({
    binary = "/usr/bin/wayfreeze",
    type = "screencopy",
    mode = "allow",
})

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
