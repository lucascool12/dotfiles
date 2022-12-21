
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

plugins=(
    zsh-nvm
    rust
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh
ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)
bindkey '^ ' autosuggest-accept
eval "$(starship init zsh)"
