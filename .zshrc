# Environment
export EDITOR=nvim
export PATH="$HOME/.tmux/plugins/tmuxifier/bin:$PATH"
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
export PUPPETEER_SKIP_CHROMIUM_DOWNLOAD=true # for docs-ng

## Dotnet
export PATH="$HOME/.dotnet/tools:$PATH"
. ~/.asdf/plugins/dotnet/set-dotnet-env.zsh

export KERL_BUILD_DOCS=yes
# export KERL_CONFIGURE_OPTIONS="--with-odbc=/opt/homebrew/opt/unixodbc"
# export CPPFLAGS="${CPPFLAGS+"$CPPFLAGS "}-I/opt/homebrew/opt/unixodbc/include"
# export LDFLAGS="${LDFLAGS+"$LDFLAGS "}-L/opt/homebrew/opt/unixodbc/lib"

if [ -f "/opt/homebrew/bin/brew" ]; then
  # If you're using macOS, you'll want this enabled
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Autocompletion of programs installed with Homebrew
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

# Set the directory to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download zinit, if it's not there yet
if [ ! -d $ZINIT_HOME ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::asdf
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx

# Load zsh-completions
fpath=(~/.zsh/completion $fpath)
autoload -U compinit && compinit
zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:*:docker-*:*' option-stacking yes

# Load CLI autocompletion.
source <(ng completion script)
source <(kubectl completion zsh)

# Aliases
alias ls="ls --color"
alias vim="nvim"
alias c="clear"
alias k="kubectl"
alias lg="lazygit"
alias tls="tmux list-session"
alias ta="tmux a"
alias l="ls -lh"
alias la="ls -lah"
alias colima-clean="rm -rf $HOME/.colima/_lima/_networks/user-v2"
alias pn="pnpm"

# Java
. ~/.asdf/plugins/java/set-java-home.zsh

# Shell integrations
eval "$(starship init zsh)"
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(tmuxifier init -)"

# pnpm
export PNPM_HOME="/Users/josayko/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
