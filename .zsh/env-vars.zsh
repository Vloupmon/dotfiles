# Locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PAGER=less
## Exercism https://exercism.org/
export fpath=($slim_path/plugins/exercism/exercism_completion.zsh
$fpath)
export PATH="$PATH:/home/vincent/.local/bin"
## Make fzf use Ripgrep
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
## Set zsh-autosuggest color, made to be used with the OneHalf Dark colour scheme
## https://github.com/sonph/onehalf
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'
# Bat theme
export BAT_THEME="OneHalfDark"
