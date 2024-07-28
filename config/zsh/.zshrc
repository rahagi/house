# main conf
wal_dir="$HOME/.cache/wal"
[[ -d "$wal_dir" ]] && (cat "$wal_dir"/sequences &)
autoload -U colors && colors

PROMPT="%B%F{blue}👺%f %F{green}%1/%f%b "
setopt NO_NOMATCH
setopt autocd
stty stop undef
setopt interactive_comments

autoload -U compinit
setopt MENU_COMPLETE
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 
zmodload zsh/complist
compinit
_comp_options+=(globdots)

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%F{244}%u%F{240}(%b)%f'
# zstyle ':vcs_info:git:*' unstagedstr '●'
zstyle ':vcs_info:git:*' unstagedstr '*'
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:*' enable git

HISTSIZE=10000000
SAVEHIST=10000000
HISTFILE="$HOME/.zsh_history"

# aliases
alias zshrc="$EDITOR ~/.zshrc"
alias ls="ls --color"
alias ll="ls -al"
alias lh="ls -alh"
# alias xi="sudo xbps-install"
# alias xr="sudo xbps-remove"
# alias xq="xbps-query"
alias sxiv="sxiv -a"
alias pf="peerflix"
alias grep="grep --color"
alias egrep="egrep --color"
alias ctop="cointop"
alias py="python"
alias ipy="ipython"
alias gc="git commit"
alias ga="git add"
alias gap="git add --patch"
alias gd="git diff"
alias gl="git log"
alias gch="git checkout"
alias gr="git rebase -i"
alias open="xdg-open"
alias sv="systemctl"
alias d="docker"
alias ts="tmux new-session"
alias ta="tmux attach"
alias less="less -R"
alias evcxr="evcxr --edit-mode=vi"
alias ssh="TERM=xterm ssh"

# enable vim keybinding
bindkey -v
bindkey "^[[Z" reverse-menu-complete

# keybinding(s)
bindkey -M menuselect '^[' send-break
bindkey "^?" backward-delete-char
# bindkey "^[[A" history-beginning-search-backward-end
# bindkey "^[[B" history-beginning-search-forward-end
bindkey "${terminfo[kcuu1]}" history-beginning-search-backward-end
bindkey "${terminfo[kcud1]}" history-beginning-search-forward-end
bindkey -M vicmd "k" history-search-backward
bindkey -M vicmd "j" history-search-forward
bindkey -s "^O" "lfcd\n"
bindkey -s "^T" "st 2> /dev/null& disown %st\n"
bindkey -s "^f" "fg\n"
bindkey -s "^r" "fuzzy_history\n"
bindkey -s "^k" "kerja\n"
bindkey -s "^h" "kerja -H\n"

# custom function(s)
lfcd() {
    export LF_CD_FILE=/tmp/.lfcd-$$
    command lf $@
    if [ -s "$LF_CD_FILE" ]; then
        local DIR="$(realpath "$(cat "$LF_CD_FILE")")"
        if [ "$DIR" != "$PWD" ]; then
            cd "$DIR"
        fi
        rm "$LF_CD_FILE"
    fi
    unset LF_CD_FILE
}

mkcd() {
  [ -d "$@" ] && echo "directory exists" && cd "$@" && return;
  mkdir -p "$@" && cd "$@"
}

fuzzy_history() {
  cmd=$(fzf < "$HOME/.zsh_history" | tr -d '\n') 
  echo "$cmd" | xclip -selection clipboard
  print -z "$cmd"
}

cheat() {
  curl -s cht.sh/"$1""$2" | less
}

# other inits
source "$HOME"/.zprofile
eval "$(direnv hook zsh)"

