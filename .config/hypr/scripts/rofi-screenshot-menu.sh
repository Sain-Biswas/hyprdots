#!/usr/bin/env sh



: '
Description:
  Rofi frontend for utility-screenshot.

Dependencies:
  - rofi
  - utility-screenshot

UI Layout:
  2x2 grid displaying available screenshot modes.
'



: '
Screenshot mode launcher.

Displays a Rofi menu allowing the user to choose a screenshot capture mode and forwards the selection to the utility-screenshot script.

Available modes:
  SMART      - Intelligent region/window/output selection
  WINDOWS    - Select a window from the current workspace
  FULLSCREEN - Capture the focused monitor
  REGION     - Free-form area selection
'
SCREENSHOT_MODE=$(
    echo -e "SMART\nWINDOWS\nFULLSCREEN\nREGION" |
        rofi -dmenu \
            -theme "$HOME/hyprdots/.config/rofi/screenshot.rasi"
)



# Exit if the menu was cancelled.
[ -z "$SCREENSHOT_MODE" ] && exit 0

sleep .1

# Launch the screenshot utility with the selected mode.
case "$SCREENSHOT_MODE" in
    "SMART")
        $HOME/hyprdots/.config/hypr/scripts/utility-screenshot.sh smart
        ;;
    "WINDOWS")
        $HOME/hyprdots/.config/hypr/scripts/utility-screenshot.sh windows
        ;;
    "FULLSCREEN")
        $HOME/hyprdots/.config/hypr/scripts/utility-screenshot.sh fullscreen
        ;;
    "REGION")
        $HOME/hyprdots/.config/hypr/scripts/utility-screenshot.sh region
        ;;
    *)
        exit 1
        ;;
esac
