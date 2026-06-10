#!/usr/bin/env sh

# ░█▀█░█▀█░█▀▀░█▀█░░░█▀▄░█▀█░█▀▀░▀█▀░░░█▄█░█▀▀░█▀█░█░█
# ░█░█░█▀▀░█▀▀░█░█░░░█▀▄░█░█░█▀▀░░█░░░░█░█░█▀▀░█░█░█░█
# ░▀▀▀░▀░░░▀▀▀░▀░▀░░░▀░▀░▀▀▀░▀░░░▀▀▀░░░▀░▀░▀▀▀░▀░▀░▀▀▀

# Strict Mode
set -euo pipefail


# Script Variables
DEBUG=false

ROFI_THEME_LAUNCHER="$HOME/hyprdots/.config/rofi/app-launcher.rasi"
ROFI_THEME_EMOJI="$HOME/hyprdots/.config/rofi/emoji-selector.rasi"
ROFI_THEME_WINDOWS="$HOME/hyprdots/.config/rofi/active-window.rasi"


# Logging Utilities
debug() {
    if [[ "$DEBUG" == true ]]; then
        notify-send -a rofi-menu -u low -i script "Open Rofi Menu" "[DEBUG] $*"
    fi
}

error() {
    notify-send -a rofi-menu -u critical -i script "Open Rofi Menu" "[ERROR] $*"
}


# Check if needed dependencies are present
check_dependencies() {
    local deps=("rofi" "uwsm-app")

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            error "Required dependency '$cmd' is not installed."
            exit 2
        fi
    done

    debug "All dependencies are satisfied."
}


# Help Message
show_help() {
    cat <<EOF
Usage: $0 <command> [--debug]

Commands:
  app        Launch application launcher (drun)
  emoji      Open emoji selector
  window     Show window switcher
  help       Display this help message

Options:
  --debug    Enable debug output
EOF
}


# Rofi Application Launcher
launch_application_launcher() {
    debug "Launching Application Launcher Menu"
    uwsm app -- rofi -show drun -display-drun "Applications" -run-command "uwsm app -- {cmd}" -theme "$ROFI_THEME_LAUNCHER"
}


# Rofi Emoji Selector
launch_emoji_selector() {
    debug "Launching emoji picker"
    uwsm app -- rofi -emoji-format "{emoji}" -show emoji -modi emoji -display-emoji "Emoji" -theme "$ROFI_THEME_EMOJI"
}


# Rofi application window selector
launch_active_window_selector() {
    debug "Launching Window switcher"
    uwsm app -- rofi -show window -display-window "Windows" -theme "$ROFI_THEME_WINDOWS"
}


# User Argument Parsing
parse_arguments() {
    if [[ $# -lt 1 ]]; then
        error "No command provided by user"
        show_help
        exit 1
    fi

    COMMAND="$1"
    shift

    while [[ $# -gt 0 ]]; do
        case "$1" in
            --debug)
                DEBUG=true
                ;;
            *)
                error "Unknown option: $1"
                exit 1
                ;;
        esac
        shift
    done
}


# Main Dispatcher
main() {
    parse_arguments "$@"
    check_dependencies

    debug "Command: $COMMAND"

    case "$COMMAND" in
        app)
            launch_application_launcher
            ;;
        emoji)
            launch_emoji_selector
            ;;
        window)
            launch_active_window_selector
            ;;
        help)
            show_help
            ;;
        *)
            error "Unknown Command: $COMMAND"
            show_help
            exit 1
            ;;
    esac
}


# Entry Point
main "$@"
