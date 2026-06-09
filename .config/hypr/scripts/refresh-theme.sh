#!/usr/bin/env sh

# ░█▀▄░█▀▀░█▀▀░█▀▄░█▀▀░█▀▀░█░█░░░▀█▀░█░█░█▀▀░█▄█░█▀▀
# ░█▀▄░█▀▀░█▀▀░█▀▄░█▀▀░▀▀█░█▀█░░░░█░░█▀█░█▀▀░█░█░█▀▀
# ░▀░▀░▀▀▀░▀░░░▀░▀░▀▀▀░▀▀▀░▀░▀░░░░▀░░▀░▀░▀▀▀░▀░▀░▀▀▀

# Strict Mode
set -euo pipefail


# Script Variables
DEBUG=false


# Logging Utilities
log() {
    notify-send -u normal -i script "Refresh theme script" "[INFO] $*"
}

debug() {
    if [[ "$DEBUG" == true ]]; then
        notify-send -u low -i script "Refresh theme script" "[DEBUG] $*"
    fi
}

error() {
    notify-send -u critical -i script "Refresh theme script" "[ERROR] $*"
}


# Check if needed dependencies are present
check_dependencies() {
    local deps=("waybar" "swaync-client")

    for cmd in "${deps[@]}"; do
        if ! command -v "$cmd" >/dev/null 2>&1; then
            error "Required dependency '$cmd' is not installed."
            exit 2
        fi
    done

    debug "All dependencies are satisfied."
}
check_dependencies



# Refresh waybar configuration and styling
debug "Refreshing Waybar theme"
pkill -SIGUSR2 waybar


# Refresh Swaync configuration and styling
debug "Refreshing swaync configuration and theme"
swaync-client -R -rs


























#
