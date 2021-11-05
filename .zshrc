# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile HISTSIZE=1000
SAVEHIST=1000
# End of lines configured by zsh-newuser-install
# Locales
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export PAGER=less
export fpath=($slim_path/plugins/exercism/exercism_completion.zsh
$fpath)
export PATH="$PATH:/home/vincent/.local/bin"
# Make fzf use Ripgrep
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vincent/.zshrc'
zstyle ':completion:*' menu select
autoload -Uz compinit
compinit
# End of lines added by compinstall

# Slim Zsh
source "$HOME/.slimzsh/slim.zsh"

bindkey '^[[Z' autosuggest-accept

# Aliases
if [[ -f $slim_path/aliases.zsh.local ]]; then
    source $slim_path/aliases.zsh.local
fi

# Nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# place this after nvm initialization!
autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
