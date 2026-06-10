#!/usr/bin/env sh



: '
Hyprpicker + Pastel Color Picker

Features:
    - Pick colors using Hyprpicker
    - Convert to multiple color formats using Pastel
    - Automatically copy result to clipboard
    - Show desktop notification with color preview
    - Uses temporary files safely
    - Handles user cancellation gracefully

Dependencies:
    - hyprpicker
    - pastel
    - wl-clipboard
    - rofi
    - imagemagick
    - libnotify
'

# Strict Mode
set -euo pipefail



# Configuration
readonly ROFI_THEME="$HOME/hyprdots/.config/rofi/colorpicker.rasi"



# Script Variables
DEBUG=false



# Logging Utilities
debug() {
    if [[ "$DEBUG" == true ]]; then
        notify-send -a Hyprpicker -u low -i script "Colorpicker" "[DEBUG] $*"
    fi
}

error() {
    notify-send -a Hyprpicker -u critical -i script "Colorpicker" "[ERROR] $*"
}



# Check if needed dependencies are present
check_dependencies() {
    local deps=("hyprpicker" "pastel" "wl-copy" "wl-paste" "rofi" "magick" "notify-send")

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            error "Required dependency '$cmd' is not installed."
            exit 2
        fi
    done

    debug "All dependencies are satisfied."
}
check_dependencies



# Notification Helper
notify_color() {
    local title="$1"
    local value="$2"
    local preview="$3"

    if [[ -n "$preview" ]]; then
        notify-send -a "Hyprpicker" "$title" "$value" -i "$preview"
    else
        notify-send -a "Hyprpicker" "$title" "$value"
    fi
}



# Generic color picker
pick_color() {
    local format="$1"
    local label="$2"

    local value
    local hex
    local preview

    # Launch Hyprpicker
    hex="$( hyprpicker --format=hex )"
    value="$( printf '%s' "$hex" | pastel format "$format" )"

    # User cancelled
    [[ -z "$value" ]] && exit 0

    printf "%s" "$value" | wl-copy

    preview="$( mktemp --suffix=.png )"

    magick -size 64x64 "xc:$hex" "$preview"

    notify_color "$label copied" "$value" "$preview"

    rm -f "$preview"
}



# Rofi Menu
rofi_menu() {
    echo -e "HEX\nRGB\nHSL\nHSV\nLAB\nLCH\nOKLAB\nOKLCH\nLUMINANCE\nNAME" | rofi -dmenu -theme "$ROFI_THEME" || exit 0
}

choice="$(rofi_menu)"



case "$choice" in
    "HEX")         pick_color hex         "HEX color"   ;;
    "RGB")         pick_color rgb         "RGB color"   ;;
    "HSL")         pick_color hsl         "HSL color"   ;;
    "HSV")         pick_color hsv         "HSV color"   ;;
    "LAB")         pick_color lab         "LAB color"   ;;
    "LCH")         pick_color lch         "LCH color"   ;;
    "OKLAB")       pick_color oklab       "OKLAB color" ;;
    "OKLCH")       pick_color oklch       "OKLCH color" ;;
    "LUMINANCE")   pick_color luminance   "Luminance"   ;;
    "NAME")        pick_color name        "Color name"  ;;
    *) exit 0 ;;
esac
