#!/bin/bash
say() {
    local IFS=+;
    if ! /usr/bin/mplayer -softvol -volume 60 -ao alsa -really-quiet -noconsolecontrols "http://translate.google.com/translate_tts?tl=en&q=$*"; then
        espeak $*
    fi
} 2>/dev/null

say $*

