#!/usr/bin/env bash

function start_switch_to {
    local APP_NAME=$1
    local APP_EXEC=$2
    local WM_CLASS=$3

    # to be able to retrieve the return code of the command instead of the one
    # from the declaration of the local variable, "execute" the declaration
    # first[^1]
    #
    # [^1]: https://stackoverflow.com/a/4421282
    local WINDOWS
    WINDOWS=$(wmctrl -lx | grep "$WM_CLASS")
    if [ $? -ne 0 ]; then
        notify-send \
            --icon=dialog-error \
            "Unable to switch to $APP_NAME" \
            "No running instance was found."
        return 1
    fi

    local COUNT
    COUNT=$(echo "$WINDOWS" | wc -l)
    if [ "$COUNT" -ne 1 ]; then
        notify-send \
            --icon=dialog-error \
            "Unable to switch to $APP_NAME" \
            "More than one instance was found ($COUNT)."
        return 2
    fi

    local WIN
    WIN=$(echo "$WINDOWS" | cut --delimiter=' ' --fields=1)
    wmctrl -i -a "$WIN"
    return $?
}
