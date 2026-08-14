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



--  Bezier curves

--  Classic eases
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInQuint", { type = "bezier", points = { { 0.64, 0 }, { 0.78, 0 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.16, 1 }, { 0.3, 1 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0, 0.55 }, { 0.45, 1 } } })
hl.curve("easeInOutCirc", { type = "bezier", points = { { 0.85, 0 }, { 0.15, 1 } } })

--  Material Design 3 curves (great for layers/menus, very "premium" feel)
hl.curve("md3Standard", { type = "bezier", points = { { 0.2, 0 }, { 0, 1 } } })
hl.curve("md3Decel", { type = "bezier", points = { { 0.05, 0.7 }, { 0.1, 1 } } })
hl.curve("md3Accel", { type = "bezier", points = { { 0.3, 0 }, { 0.8, 0.15 } } })

--  Slight overshoot, nice for popin windows without needing a spring
hl.curve("overshot", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.1 } } })

--  Utility curves
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.curve("balanced", { type = "bezier", points = { { 1, 0.5 }, { 0, 0.5 } } })

--  Spring curves

--  Soft, natural bounce for opening/closing windows
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

--  Snappier, more energetic spring for interactive movement (dragging, resizing)
hl.curve("snappy", { type = "spring", mass = 0.8, stiffness = 110, dampening = 14 })

--  Very light, barely-there spring for subtle border/active-window transitions
hl.curve("subtle", { type = "spring", mass = 1, stiffness = 90, dampening = 20 })





--  Animation declarations

hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })

--  Windows
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.5, spring = "easy", style = "popin 85%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 2.2, bezier = "easeInQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 3.2, spring = "snappy" })

--  Layers (menus, launchers, notifications, bars)
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "md3Decel" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 3.5, bezier = "md3Decel", style = "popin 90%" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 2.2, bezier = "md3Accel", style = "fade" })

--  Fade
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.9, bezier = "easeOutExpo" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.6, bezier = "easeInQuint" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 2, bezier = "easeOutExpo" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.5, bezier = "easeInQuint" })

--  Border
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })

--  Workspaces (slide + fade reads far more "alive" than a flat fade)
hl.animation({ leaf = "workspaces", enabled = true, speed = 3.2, bezier = "easeOutCirc", style = "slidefade 15%" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 2.6, bezier = "easeOutExpo", style = "slidefade 15%" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 2.2, bezier = "easeInQuint", style = "slidefade 15%" })

--  Zoom Factor
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "balanced" })
