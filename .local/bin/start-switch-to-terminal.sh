#!/usr/bin/env sh

. "$(dirname "$0")"/start-switch-to.sh

APP_NAME="Terminal"
APP_EXEC="xfce4-terminal --maximize"
WM_CLASS="xfce4-terminal.Xfce4-terminal"

start_switch_to "$APP_NAME" "$APP_EXEC" $WM_CLASS
