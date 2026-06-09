#! /usr/bin/env sh

# ░█▀▄░█▀█░█▀▀░▀█▀░░░█▀█░█▀█░█░█░█▀▀░█▀▄░░░█▄█░█▀▀░█▀█░█░█
# ░█▀▄░█░█░█▀▀░░█░░░░█▀▀░█░█░█▄█░█▀▀░█▀▄░░░█░█░█▀▀░█░█░█░█
# ░▀░▀░▀▀▀░▀░░░▀▀▀░░░▀░░░▀▀▀░▀░▀░▀▀▀░▀░▀░░░▀░▀░▀▀▀░▀░▀░▀▀▀

: '
Description:
    Rofi based power menu for Hyprland.

Dependencies:
    - rofi
    - hyprlock
    - hyprshutdown
    - systemd

Themes:
    $HOME/hyprdots/.config/rofi/power-menu.rasi
    $HOME/hyprdots/.config/rofi/confirm-dialog.rasi
'

: '
Display the power menu using Rofi and return the selected action.

Available actions:
    - LOCK
    - LOGOUT
    - SUSPEND
    - HIBERNATE
    - SHUTDOWN
    - REBOOT

Exits silently if the menu is cancelled.
'
command() {
    echo -e "LOCK\nLOGOUT\nSUSPEND\nHIBERNATE\nSHUTDOWN\nREBOOT" | rofi -dmenu -theme "$HOME/hyprdots/.config/rofi/power-menu.rasi" || exit 0
}

: '
Display a confirmation dialog before executing potentially destructive power actions.

Returns:
    - YES
    - NO

Exits silently if the dialog is cancelled.
'
confirm() {
    echo -e "YES\nNO" | rofi -dmenu -theme "$HOME/hyprdots/.config/rofi/confirm-dialog.rasi" || exit 0
}

: '
Execute a power action after user confirmation.

Supported actions:
    --shutdown: Power off the system
    --reboot  : Restart the system
    --logout  : End the current Hyprland session
    --suspend : Lock the screen and suspend

A confirmation dialog is always shown before executing the requested action.
'
execute() {
    selected="$(confirm)"

    if [[ "$selected" == "YES" ]]; then
        if [[ $1 == "--shutdown" ]]; then
            hyprshutdown -t "Shutting down ..." --post-cmd "shutdown -P 0"
        elif [[ $1 == "--reboot" ]]; then
            hyprshutdown -t "Restarting ..." --post-cmd "reboot"
        elif [[ $1 == "--logout" ]]; then
            hyprshutdown
        elif [[ $1 == "--suspend" ]]; then
            hyprlock -f || systemctl suspend
        fi
    else
        exit 0
    fi
}

# Show the power menu and store the user's selection
choosen="$(command)"

# Dispatch the selected action
case ${choosen} in
    "LOCK")
        # Prevent multiple lock screen instances.
        pidof hyprlock || hyprlock
        ;;
    "LOGOUT")
        execute --logout
        ;;
    "SUSPEND")
        execute --suspend
        ;;
    "HIBERNATE")
        # Lock the screen before hibernating.
        hyprlock -f || systemctl hibernate
        ;;
    "SHUTDOWN")
        execute --shutdown
        ;;
    "REBOOT")
        execute --reboot
        ;;
esac
