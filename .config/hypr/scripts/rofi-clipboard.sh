#!/usr/bin/env sh

# ░█▀▄░█▀█░█▀▀░▀█▀░░░░░░░░░█▀▀░█░░░▀█▀░█▀█░█▀▄░█▀█░█▀█░█▀▄░█▀▄░░░░
# ░█▀▄░█░█░█▀▀░░█░░░░▄▄▄░░░█░░░█░░░░█░░█▀▀░█▀▄░█░█░█▀█░█▀▄░█░█░░░░
# ░▀░▀░▀▀▀░▀░░░▀▀▀░░░░░░░░░▀▀▀░▀▀▀░▀▀▀░▀░░░▀▀░░▀▀▀░▀░▀░▀░▀░▀▀░░░░░


: '
Clipboard History Picker

A Rofi-based frontend for cliphist on Wayland.

Features:
    - Search clipboard history with Rofi
    - Clipboard content previews
    - Context-aware icons
    - Desktop notifications for errors
    - Copies selected entry back to clipboard

Dependencies:
    - cliphist
    - rofi
    - wl-copy
    - notify-send

Workflow:
    cliphist -> decode previews -> rofi selection -> decode entry -> wl-copy
'



# Strict Mode
set -euo pipefail

# Logging Utilities
error() {
    notify-send -a clipboard -u critical -i dialog-error "Rofi Clipboard Manager" "[ERROR] $*"
}

# Check if needed dependencies are present
check_dependencies() {
    local deps=("cliphist" "rofi" "wl-copy" "notify-send" "zsh")

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            error "Required dependency '$cmd' is not installed."
            exit 2
        fi
    done
}
check_dependencies



# UI Configuration
ROFI_PROMPT="Clipboard"
ROFI_LINES=15
ROFI_WIDTH="50%"

# Maximum preview length desplayed in Rofi
MAX_PREVIEW_LEN=80

# Notification Configuration
NOTIFY_APP_NAME="clipboard_rofi_script"

# Icon Mappings (freedesktop standard)
ICON_ERROR="dialog-error"
ICON_TEXT="text-x-generic"
ICON_URL="network-workgroup"
ICON_IMAGE="image-x-generic"
ICON_COMMAND="utilities-terminal"
ICON_DEFAULT="edit-paste"



# Preview Helpers
: '
Truncate preview text for display.

Prevents very long clipboard entries from overwhelming the Rofi menu.
'
truncate() {
    local str="$1"
    local max_len="$2"

    if (( ${#str} > max_len )); then
        printf "%s...\n" "${str:0:max_len}"
    else
        printf "%s\n" "$str"
    fi
}

: '
Determine an icon based on clipboard content.

Heuristics:
    URL      -> network icon
    Image    -> image icon
    Command  -> terminal icon
    Text     -> text icon
'
detect_icon() {
    local entry="$1"

    if [[ "$entry" =~ ^https?:// ]]; then
        echo "$ICON_URL"
    elif [[ "$entry" =~ ^data:image ]]; then
        echo "$ICON_IMAGE"
    elif [[ "$entry" =~ ^(sudo|pacman|git|cd|ls|rm|cp|mv|bun|paru|pnpm|npm|node) ]]; then
        echo "$ICON_COMMAND"
    elif [[ "$entry" =~ [[:print:]] ]]; then
        echo "$ICON_TEXT"
    else
        echo "$ICON_DEFAULT"
    fi
}



: '
Generate Rofi entries

Each clipboard item is decoded and the first line is used as a preview. Icons are attached using Rofis metadata format.
'
format_entries() {
    cliphist list | while IFS= read -r line; do

        preview=$(cliphist decode "$line="- 2>/dev/null | head -n1 || true)

        preview=$(truncate "$preview" "$MAX_PREVIEW_LEN")
        icon=$(detect_icon "$preview")

        printf "%s\0icon\x1f%s\n" "$preview" "$icon"
    done
}




# Main Application
main() {
    local selected index entry preview

    # Display clipboard history in Rofi
    selected=$( format_entries | rofi -dmenu -p "$ROFI_PROMPT" -l "$ROFI_LINES" -show-icons -width "$ROFI_WIDTH" -theme "$HOME/hyprdots/.config/rofi/clipboard.rasi" )

    # User cancelled selection
    [[ -z "$selected" ]] && exit 0

    : '
    Resolve seected preview back to the original cliphist entry index.

    Note:
        This relies on preview text being unique
    '
    index=$(
        cliphist list | nl -w1 -s' ' |
        while read -r i line; do
            preview=$( cliphist decode "$line" 2>/dev/null | head -n1 || true )
            preview=$( truncate "$preview" "$MAX_PREVIEW_LEN" )

            if [[ "$preview" == "$selected" ]]; then
                echo "$i"
                break
            fi
        done
    )

    [[ -z "$index" ]] && {
        error "Failed to resolve selection"
        exit 2
    }

    # Retrieve original cliphist entry
    entry=$( cliphist list | sed -n "${index}p" )

    # Decode and restore to clipboard
    if ! cliphist decode "$entry" | wl-copy; then
        error "Failed to copy selection."
        exit 2
    fi
}



# Script entry point
main "$@"
