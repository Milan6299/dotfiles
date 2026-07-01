# ENVIRONMENT
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_MUSIC_DIR="$HOME/music"
export EDITOR="nvim"
export LS_COLORS="$LS_COLORS:ow=32"

# HISTORY
HISTSIZE=5000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_find_no_dups

unsetopt prompt_sp

# COMPLETION
autoload -Uz compinit

if [[ -n ${ZDOTDIR:-$HOME}/.zcompdump(#qN.mh+24) ]]; then
    compinit
else
    compinit -C
fi

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ""
zstyle ':completion:*' menu select

# ZOXIDE
eval "$(zoxide init zsh)"

# FZF TAB
source ~/.fzf-tab/fzf-tab.plugin.zsh

zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color=auto $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color=auto $realpath'

# GIT BRANCH IN PROMPT
setopt prompt_subst

autoload -Uz vcs_info

precmd() {
    vcs_info
}

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:git:*' formats ' %b*'
zstyle ':vcs_info:git:*' actionformats ' %b*'

PROMPT='%F{cyan}%c%f ${vcs_info_msg_0_:+$vcs_info_msg_0_}%F{yellow}❯%f '
RPROMPT=''

# FZF
eval "$(fzf --zsh)"

# ALIASES
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias c='clear'
alias syu='sudo pacman -Syu'
alias yu='yay -Syu'
alias v='nvim'
alias tn='tmux new-session -s'
alias tls='tmux list-sessions'
alias ta='tmux attach-session'
alias td='tmux detach'
alias y='yazi'
alias dnd='makoctl mode -t dnd'
alias rt='trashy'
alias pmy='python manage.py'
alias ts='tmux-sessionizer'
alias sys='systemctl --user'
alias ssh='ssh-notify'
alias updots='~/.local/bin/update-dots'
alias pod='noglob pod'
alias tk='tmux kill-session -t'

# FUNCTIONS
zm() {
    local dir
    dir="$(zoxide query --interactive "$@")" || return
    [[ -n "$dir" ]] && cd "$dir"
}

# KEYBINDINGS
bindkey -v

bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^P' up-line-or-history
bindkey '^N' down-line-or-history

bindkey -M menuselect >/dev/null 2>&1 || bindkey -N menuselect

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# ~/.local/bin/checktmux
