#!/usr/bin/env bash

. "$(dirname "$0")"/start-switch-to.sh

APP_NAME="Emacs"
APP_EXEC="emacs"
WM_CLASS="emacs.Emacs"

start_switch_to "$APP_NAME" "$APP_EXEC" $WM_CLASS
