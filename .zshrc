# Download Znap, if it's not there yet.
[[ -f ~/Git/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Git/zsh-snap

source ~/Git/zsh-snap/znap.zsh  # Start Znap

znap eval starship 'starship init zsh --print-full-init'
znap prompt

znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source lukechilds/zsh-nvm

ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)
bindkey '^ ' autosuggest-accept
eval "$(starship init zsh)"
