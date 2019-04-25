source "${HOME}/antigen/antigen.zsh"

antigen use prezto
antigen bundle sorin-ionescu/prezto modules/environment
antigen bundle sorin-ionescu/prezto modules/terminal
antigen bundle sorin-ionescu/prezto modules/editor
antigen bundle sorin-ionescu/prezto modules/history
antigen bundle sorin-ionescu/prezto modules/helper
antigen bundle sorin-ionescu/prezto modules/utility
antigen bundle sorin-ionescu/prezto modules/completion
antigen bundle sorin-ionescu/prezto modules/prompt
antigen theme sorin

antigen bundle robbyrussell/oh-my-zsh plugins/git
antigen bundle robbyrussell/oh-my-zsh plugins/vi-mode
antigen bundle robbyrussell/oh-my-zsh plugins/extract

antigen bundle zsh-users/zsh-autosuggestions

antigen apply

autoload -Uz promptpwd
prompt sorin

# Customize to your needs...

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.config/amzn/zshrc ]] && source ~/.config/amzn/zshrc
source "$HOME/.nix-profile/etc/profile.d/nix.sh"
setxkbmap -option caps:escape

# Hacks to fix Intellij on bspwm
export _JAVA_AWT_WM_NONREPARENTING=1
wmname LG3D

# Aliases
alias vim="nvim"
alias ez="nvim $HOME/.zshrc; source $HOME/.zshrc"
alias :q='echo "This is not vim"'
alias ls='ls --color=auto'
alias lock="gnome-screensaver-command -l"

## Tmux aliases
alias tma="tmux attach -t"
alias tmn="tmux new -s"

## Git aliases
alias gmff='git merge --ff-only'
alias gcar='git add --all && git commit --amend --reuse-message HEAD'
alias gdh='git diff HEAD~1'

# Exports
export VISUAL=nvim
export EDITOR=nvim
export GOPATH="$HOME/go"
export PATH="$HOME/bin:$HOME/.cargo/bin:$PATH"
export KEYTIMEOUT=1
export DOCKER_HOST='unix:///var/run/docker.sock'


# Set vi keybindings for the shell
#set -o vi
bindkey -M vicmd 'k' up-line-or-search
bindkey -M vicmd 'j' down-line-or-search
bindkey -M vicmd '/' history-incremental-pattern-search-backward
bindkey -M vicmd '?' history-incremental-pattern-search-forward
bindkey '^n' autosuggest-accept
bindkey '^p' autosuggest-clear

setopt hist_ignore_dups
setopt autopushd
