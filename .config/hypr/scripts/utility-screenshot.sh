#! /usr/bin/env sh



: '
Description:
  Hyprland screenshot utility using grim, slurp and satty.

Modes:
  - smart      (default)
  - region
  - windows
  - fullscreen

Dependencies:
  - grim
  - slurp
  - satty
  - wl-copy
  - hyprctl
  - jq
  - wayfreeze

Usage:
  - screenshot.sh [mode] [processing]

Examples:
  - screenshot.sh smart
  - screenshot.sh region
  - screenshot.sh fullscreen copy
'



# Strict Mode
set -euo pipefail


# Logging Utilities
error() {
    notify-send -a screenshot-utility -u critical -i script "Screenshot Utility" "[ERROR] $*"
}


# Check if needed dependencies are present
check_dependencies() {
    local deps=("grim" "slurp" "satty" "wl-copy" "hyprctl" "jq" "wayfreeze")

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            error "Required dependency '$cmd' is not installed."
            exit 2
        fi
    done
}

check_dependencies



: '
Load XDG user directory definitions if available.
This provides variables such as XDG_PICTURES_DIR.
'
[[ -f ~/.config/user-dirs.dirs ]] && source ~/.config/user-dirs.dirs



: '
Directory where screenshots will be saved.

Priority:
    1. SCREENSHOT_DIR
    2. XDG_PICTURES_DIR
    3. $HOME/Pictures/Screenshot
'
OUTPUT_DIR="${SCREENSHOT_DIR:-$XDG_PICTURES_DIR/Screenshot}"



# Create the output directory if it does not exist.
if [[ ! -d "$OUTPUT_DIR" ]]; then
    mkdir -p "$OUTPUT_DIR"
fi



: '
Prevent multiple slurp instances.
If one is already running, terminate it and exit.
'
pkill slurp && exit 0



: '
Screenshot mode:
    - smart        : region/window/output selection with click detection
    - region       : free-form region selection
    - windows      : snap selection to visible windows
    - fullscreen   : currently focused monitor
'
MODE="${1:-smart}"



: '
Post-processing mode:
    slurp - open screenshot in satty for annotation
    copy  - copy directly to clipboard
'
PROCESSING="${2:-slurp}"



: '
Generate selectable rectangles for slurp

Includes:
    - Active workspace monitor bounds
    - All client windows on the active workspace

Output format:
    x,y width x height
'
get_rectangles() {
    local active_workspace=$( hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .activeWorkspace.id' )

    # Monitor region
    hyprctl monitors -j |
        jq -r --arg ws "$active_workspace" \
        '.[] | select(.activeWorkspace.id == ($ws | tonumber))
        | "\(.x),\(.y) \((.width / .scale) | floor)x\((.height / .scale) | floor)"'

    # Window regions
    hyprctl clients -j |
        jq -r --arg ws "$active_workspace" \
            '.[] | select(.workspace.id == ($ws | tonumber))
            | "\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"'
}



# Select screenshot area according to the chosen mode.
case "$MODE" in

  # Free-form region selection.
  region)
    wayfreeze & PID=$!
    sleep .1
    SELECTION=$(slurp 2>/dev/null)
    kill $PID 2>/dev/null
    ;;

  # Restrict selection to window rectangles.
  windows)
    wayfreeze & PID=$!
    sleep .1
    SELECTION=$(get_rectangles | slurp -r 2>/dev/null)
    kill $PID 2>/dev/null
    ;;

  # Capture the entire focused monitor.
  fullscreen)
    SELECTION=$(
      hyprctl monitors -j |
      jq -r '.[] | select(.focused == true)
      | "\(.x),\(.y) \((.width / .scale) | floor)x\((.height / .scale) | floor)"'
    )
    ;;

  # Smart mode:
  #   - Shows monitor and window rectangles.
  #   - Allows free selection.
  #   - If the selected area is tiny (< 20 pixels),
  #     treat it as a click and automatically select
  #     the window/output under the cursor.
  smart|*)
    RECTS=$(get_rectangles)

    wayfreeze & PID=$!
    sleep .1
    SELECTION=$(echo "$RECTS" | slurp 2>/dev/null)
    kill $PID 2>/dev/null

    # Detect accidental click selections.
    # A very small region is assumed to be a click.
    if [[ "$SELECTION" =~ ^([0-9]+),([0-9]+)[[:space:]]([0-9]+)x([0-9]+)$ ]]; then
      if (( ${BASH_REMATCH[3]} * ${BASH_REMATCH[4]} < 20 )); then
        click_x="${BASH_REMATCH[1]}"
        click_y="${BASH_REMATCH[2]}"

        # Find the first rectangle containing the click
        # and use it as the final selection.
        while IFS= read -r rect; do
          if [[ "$rect" =~ ^([0-9]+),([0-9]+)[[:space:]]([0-9]+)x([0-9]+) ]]; then
            rect_x="${BASH_REMATCH[1]}"
            rect_y="${BASH_REMATCH[2]}"
            rect_width="${BASH_REMATCH[3]}"
            rect_height="${BASH_REMATCH[4]}"

            if (( click_x >= rect_x &&
                  click_x < rect_x + rect_width &&
                  click_y >= rect_y &&
                  click_y < rect_y + rect_height )); then
              SELECTION="${rect_x},${rect_y} ${rect_width}x${rect_height}"
              break
            fi
          fi
        done <<< "$RECTS"
      fi
    fi
    ;;
esac



# User cancelled selection.
[ -z "$SELECTION" ] && exit 0



# Capture screenshot.
if [[ $PROCESSING == "slurp" ]]; then

  # Open in Satty for annotation/editing.
  # On Enter:
  #   - Save file
  #   - Copy to clipboard
  grim -g "$SELECTION" - |
    satty --filename - \
      --output-filename "$OUTPUT_DIR/screenshot-$(date +'%Y-%m-%d_%H-%M-%S').png" \
      --early-exit \
      --actions-on-enter save-to-clipboard \
      --save-after-copy \
      --copy-command 'wl-copy'

else

  # Direct clipboard capture without opening Satty.
  grim -g "$SELECTION" - | wl-copy

fi
