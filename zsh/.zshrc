source "${HOME}/.antigen.zsh"

antigen use prezto
antigen bundle sorin-ionescu/prezto modules/environment
antigen bundle sorin-ionescu/prezto modules/terminal
antigen bundle sorin-ionescu/prezto modules/history
antigen bundle sorin-ionescu/prezto modules/completion
antigen bundle sorin-ionescu/prezto modules/helper
antigen bundle sorin-ionescu/prezto modules/editor
antigen bundle sorin-ionescu/prezto modules/prompt

antigen bundle robbyrussell/oh-my-zsh plugins/git
antigen bundle robbyrussell/oh-my-zsh plugins/vi-mode
antigen bundle robbyrussell/oh-my-zsh plugins/archlinux
antigen bundle robbyrussell/oh-my-zsh plugins/extract

antigen bundle zsh-users/zsh-autosuggestions

antigen apply

# Startup commands
prompt sorin
wmname LG3D

# Exports
export KEYTIMEOUT=1
export VISUAL=nvim
export EDITOR=nvim

# Aliases
alias vim=nvim
alias ez="$EDITOR ${HOME}/.zshrc; source ${HOME}/.zshrc"
alias cwp="feh --randomize --bg-scale ${HOME}/Wallpapers/* &>/dev/null"
alias lock "dm-tool lock"
alias shutdown="sudo shutdown now"

## Tmux aliases
alias tma="tmux attach -t"
alias tmn="tmux new -s"

# Set vi keypindings for shell
bindkey -M vicmd 'k' up-line-or-search
bindkey -M vicmd 'j' down-line-or-search
bindkey '^n' autosuggest-accept
bindkey '^p' autosuggest-clear

set hist_ignore_dups
