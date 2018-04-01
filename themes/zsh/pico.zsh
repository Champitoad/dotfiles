ncolor="magenta" # Normal mode prompt color
icolor="yellow" # Insert mode prompt color

PROMPT="%F{$icolor}%(!,#,$)%f "
RPROMPT="%(?,,%B[%?]%b)"

# Change prompt color to match current mode
zle-keymap-select() {
    case $KEYMAP in
        vicmd) PROMPT=$(echo $PROMPT | sed "s/$icolor/$ncolor/");;
        viins|main) PROMPT=$(echo $PROMPT | sed "s/$ncolor/$icolor/");;
    esac
    zle reset-prompt
}
