# ░▀▀█░█▀▀░█░█░░░░░░░░░▀▀█░█▀▀░█░█░█▀▄░█▀▀
# ░▄▀░░▀▀█░█▀█░░░▄▄▄░░░▄▀░░▀▀█░█▀█░█▀▄░█░░
# ░▀▀▀░▀▀▀░▀░▀░░░░░░░░░▀▀▀░▀▀▀░▀░▀░▀░▀░▀▀▀

# set zinit home for the plugins to navigate
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# check if zinit is installed and install if not
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"



# source zinit manager
source "${ZINIT_HOME}/zinit.zsh"



# load completions and syntax highlighting
zinit wait lucid for \
    atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    blockf \
        zsh-users/zsh-completions \
    atload"!_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions



# load fzf-tab plugin for tab completions in terminal
zinit ice wait lucid
zinit light Aloxaf/fzf-tab



# load starship prompt
zinit ice as"command" from"gh-r" \
    atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
    atpull"%atclone" src"init.zsh"
zinit light starship/starship



# zsh history options
HISTSIZE=10000
SAVEHIST=$HISTSIZE
HISTFILE="$XDG_CACHE_HOME/zsh_history"
HISTCONTROL=ignoreboth
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_ignore_dups
setopt hist_save_no_dups
setopt hist_find_no_dups
setopt correct



# load fzf and zoxide
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"



# source matugen colors
source "${HOME}/hyprdots/matugen.zsh"



# zsh styling for various functions
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -a --color=always $realpath'
zstyle ':fzf-tab:*' use-fzf-default-opts yes



# aliases
alias c="clear"
alias vi="nvim"
alias vim="nvim"
alias grep="grep --color=auto"
alias mkdir="mkdir -p"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

alias ll="eza -lha --icons=auto --group-directories-first"
alias ls="eza --icons=auto -Ga --group-directories-first"
alias llt="eza -lTa --git-ignore --group-directories-first"
alias lt="eza -Ta --git-ignore --icons=auto --group-directories-first"

alias gc="git commit -m"
alias gs="git status"
alias gss="git status -s"
alias gl="git log --oneline"
alias gac="git add --all && git commit -m"
alias gll="git log"
alias gtree="git log --oneline --graph --all"
alias gtrash="git stash --include-untracked"



# pnpm
export PNPM_HOME="/home/sainbiswas/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME/bin:"*) ;;
  *) export PATH="$PNPM_HOME/bin:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/home/sainbiswas/.bun/_bun" ] && source "/home/sainbiswas/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun end
