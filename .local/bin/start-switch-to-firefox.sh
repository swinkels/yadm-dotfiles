#!/usr/bin/env sh

. "$(dirname "$0")"/start-switch-to.sh

APP_NAME="Firefox"
APP_EXEC="firefox"
WM_CLASS="Navigator.firefox"

start_switch_to "$APP_NAME" "$APP_EXEC" $WM_CLASS
