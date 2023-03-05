# Download Znap, if it's not there yet.
[[ -f ~/.znap/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.znap/zsh-snap

source ~/.znap/zsh-snap/znap.zsh  # Start Znap

znap eval starship 'starship init zsh --print-full-init'
znap prompt

zstyle ':autocomplete:*' widget-style menu-select
zstyle ':autocomplete:*' add-space \
    executables aliases functions builtins reserved-words commands

znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-syntax-highlighting
znap source lukechilds/zsh-nvm
znap source se-jaeger/zsh-activate-py-environment

zstyle ':autocomplete:*' insert-unambiguous no

ZSH_AUTOSUGGEST_STRATEGY=(
    history
    completion
)
bindkey -r '^@'
bindkey '^@' autosuggest-accept
setopt HIST_IGNORE_DUPS
