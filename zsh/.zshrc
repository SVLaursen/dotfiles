# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Zsh Plugins
plugins=(
  git
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source /Users/simonvestergaardlaursen/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# JDK SETTINGS
export JAVA_HOME="/opt/jdk/sapmachine-jdk-17.0.2.jdk/Contents/Home"
export PATH="/opt/jdk/sapmachine-jdk-17.0.2.jdk/Contents/Home/bin:$PATH"

# GOLANG SETTINGS
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:$(go env GOPATH)/bin

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/simonvestergaardlaursen/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)

# ALIASES
alias vim='nvim'
alias cat='bat'

alias exa='eza --icons'
alias ls='eza --icons'
alias lsa='eza --icons --long --header'

# Zoxide config
eval "$(zoxide init --cmd cd zsh)"

# fzf config
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(fzf --zsh)"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

source ~/.config/fzf-git.sh/fzf-git.sh # git utilities for fzf
bindkey -r "^G" # unbind the default zsh search break such that I can make use of fzf-git shortcuts

# Advanced fzf integration with eza and bat
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo $'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Shortcuts / functions
function killport {   lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill }

# ========= WORKFLOWS ============
# - Configuration workflows
alias zshcfg='nvim ~/.zshrc'
alias tmuxcfg='nvim ~/.config/tmux/tmux.conf'
alias reload-zsh='source ~/.zshrc'
alias reload-tmux='tmux source-file ~/.config/tmux/tmux.conf'
alias open-scripts='nvim ~/.config/scripts'
# - Obsidian related workflows
alias ov='nvim ~/Dev/personal/vault'

