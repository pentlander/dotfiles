# Hack to minimize compinit time to speed up shell startup
autoload -Uz compinit
setopt EXTENDEDGLOB
for dump in $HOME/.zcompdump(#qN.m1); do
    compinit
    if [[ -s "$dump" && (! -s "$dump.zwc" || "$dump" -nt "$dump.zwc") ]]; then
        zcompile "$dump"
    fi
done
unsetopt EXTENDEDGLOB
compinit -C

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

antigen bundle robbyrussell/oh-my-zsh plugins/git
antigen bundle robbyrussell/oh-my-zsh plugins/vi-mode
antigen bundle robbyrussell/oh-my-zsh plugins/extract

antigen bundle zsh-users/zsh-autosuggestions

antigen apply

autoload -Uz prompt-pwd

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Aliases
alias vim=nvim
alias ez="$EDITOR ${HOME}/.zshrc; source ${HOME}/.zshrc"
alias cwp="feh --randomize --bg-scale ${HOME}/Wallpapers/* &>/dev/null"
alias ls='ls --color=always'

# Power commands
alias suspend="systemctl suspend"
alias lock="dm-tool lock"
alias shutdown="sudo shutdown now"

## Tmux aliases
alias tma="tmux attach -t"
alias tmn="tmux new -s"

## Git aliases
alias gmff='git merge --ff-only'
alias gcar='git add --all && git commit --amend --reuse-message HEAD'
alias gdh='git diff HEAD~1'

# Exports
export KEYTIMEOUT=1
export VISUAL=nvim
export EDITOR=nvim
export GOPATH="$HOME/go"
export PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$HOME/.cargo/bin:$PATH"
export KEYTIMEOUT=1
export DOCKER_HOST='unix:///var/run/docker.sock'
export NVM_DIR="$HOME/.nvm"
## Android paths
export ANDROID_HOME=$HOME/Android/Sdk
export PATH="$PATH:$ANDROID_HOME/emulator"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/tools/bin"
export PATH="$PATH:$ANDROID_HOME/platform-tools"


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
