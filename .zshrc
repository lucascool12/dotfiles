
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Make CTRL+Arrow skip words
# rxvt
bindkey "^[Od" backward-word
bindkey "^[Oc" forward-word
# xterm
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
# gnome-terminal
bindkey "^[OD" backward-word
bindkey "^[OC" forward-word
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
