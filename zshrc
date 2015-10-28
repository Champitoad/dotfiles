# Automatic rehash to avoid reloading shell when installing new programs
setopt nohashdirs

########## Oh-My-Zsh ##########

plugins=(vi-mode chucknorris common-aliases dircycle git gitfast git-extras history-substring-search last-working-dir lol nyan systemd z)
ZSH_THEME=wezm
DEFAULT_USER=pablo
export ZSH=/home/pablo/.oh-my-zsh
source $ZSH/oh-my-zsh.sh

########## Vi-mode ##########

# Change prompt color to match current mode
ncolor='red'
icolor='yellow'
zle-keymap-select() {
    case $KEYMAP in
        vicmd) PROMPT=$(echo $PROMPT | sed "s/\$fg\[.*\]%}%#/\$fg\[$ncolor\]%}%#/");;
        viins|main) PROMPT=$(echo $PROMPT | sed "s/\$fg\[.*\]%}%#/\$fg\[$icolor\]%}%#/");;
    esac
    zle reset-prompt
}

# Escape normal mode timeout to 0.1s
export KEYTIMEOUT=1

########## Completion ##########

# Menu to choose file with completion
zstyle ':completion:*' menu select
# Proper aliases completion
setopt completealiases

########## History ##########

HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# Disable bang history expansion
setopt nobanghist

# Ignore duplicates in commands history
setopt HIST_IGNORE_ALL_DUPS
# History search matching beginning of line till cursor
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# History search matching substring with C-Up and C-Down
bindkey '^[[1;5A' history-substring-search-up
bindkey '^[[1;5B' history-substring-search-down

########## Changing directories ##########

# Key binding for browsing parent directory
cdParentKey() {
  pushd .. > /dev/null
  zle      reset-prompt
}
zle -N                 cdParentKey
bindkey '^[[1;3A'      cdParentKey

# Browse dir when just typing its name
setopt autocd

setopt autopushd    # Make cd push directories onto stack
setopt pushdsilent  # Omit printing directory stack

########## Key bindings ##########

# Store terminfo key values
typeset -A key
key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# Setup key accordingly
[[ -n "${key[Home]}"     ]]  && bindkey  "${key[Home]}"     beginning-of-line
[[ -n "${key[End]}"      ]]  && bindkey  "${key[End]}"      end-of-line
[[ -n "${key[Insert]}"   ]]  && bindkey  "${key[Insert]}"   overwrite-mode
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Left]}"     backward-char
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Right]}"    forward-char
[[ -n "${key[Left]}"     ]]  && bindkey  "${key[Up]}"       up-line-or-beginning-search
[[ -n "${key[Right]}"    ]]  && bindkey  "${key[Down]}"     down-line-or-beginning-search
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"   beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}" end-of-buffer-or-history

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
function zle-line-init () {
    printf '%s' "${terminfo[smkx]}"
    PROMPT=$(echo $PROMPT | sed "s/\$fg\[.*\]%}%#/\$fg\[$icolor\]%}%#/") # See Vi-mode part
}
function zle-line-finish () {
    printf '%s' "${terminfo[rmkx]}"
    PROMPT=$(echo $PROMPT | sed "s/\$fg\[.*\]%}%#/\$fg\[$icolor\]%}%#/") # See Vi-mode part
}
zle -N zle-line-init
zle -N zle-line-finish
fi

########## Colors ##########

# 256 colors support
export TERM=xterm-256color

# Base16 Shell
BASE16_SHELL="/home/pablo/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Colorize tree command output
LS_COLORS="rs=0:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36"
# Change default ugly color for NTFS dirs
export LS_COLORS="${LS_COLORS}:tw=01;94:ow=01;94:di=01;94"
# Colorize completion output
zstyle -e ':completion:*:default' list-colors 'reply=("${PREFIX:+=(#bi)($PREFIX:t)(?)*==34=34}:${(s.:.)LS_COLORS}")';

# Colored man pages
man() {
    env LESS_TERMCAP_mb=$'\E[01;31m' \
    LESS_TERMCAP_md=$'\E[01;38;5;74m' \
    LESS_TERMCAP_me=$'\E[0m' \
    LESS_TERMCAP_se=$'\E[0m' \
    LESS_TERMCAP_so=$'\E[38;5;246m' \
    LESS_TERMCAP_ue=$'\E[0m' \
    LESS_TERMCAP_us=$'\E[04;38;5;146m' \
    man "$@"
}

########## Day2Day configuration ##########

##### Aliases #####

# Normal aliases
alias vim="vim -p"
alias vimrc="vim ~/.vim/config/settings.vim"
alias rn="perl-rename"
alias naut="nautilus . NUL BG"
alias arcsans="sudo sed -i 's/Cantarell/NotoSans, Cantarell/g' /usr/share/themes/Arc/gnome-shell/gnome-shell.css && gnome-shell --replace NUL BG" # Arc gnome-shell theme Sans font

# Global aliases
alias -g CC=" | xclip -sel 'clipboard'" # Clipboard Copy
alias -g BG=" & disown" # Continue the process in background while detaching it from the current shell

# Unaliases
unalias rm # Override default rm -i

##### Functions #####

# Sign the APK $1 with the alias $2
function signapk {
    if [ $# -ne 2 ]; then
        echo "Usage: signapk path_to_apk alias_name"
        return
    fi

    apk=$1
    alias=$2
    keystore=`dirname $apk`/${alias}.keystore
    newapk=`dirname $1`/${alias}.apk

    keytool -genkey -keystore $keystore -alias $alias -keyalg RSA -keysize 2048 -validity 10000
    jarsigner -sigalg SHA1withRSA -digestalg SHA1 -keystore $keystore $apk $alias
    if [ -e $newapk ]; then rm $newapk; fi
    /opt/android-sdk/build-tools/21.1.1/zipalign 4 $apk $newapk
}

# Create a zip archive of the folder $1 inside itself
function tpzip {
    zip -r $1/$(basename $1).zip $1
}

# Repeat command $2 $1 times (doesn't work as of now)
function rep {
    for i in range $(seq 1 $1); do
        $2
    done
}

# Shell variables
export EDITOR=vim
export PATH="$PATH:/home/pablo/.bin"

# Zsh syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
