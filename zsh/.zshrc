# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS SHARE_HISTORY

# Prefix search on up/down arrow
autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

export PATH="/opt/homebrew/opt/openjdk@17/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
eval "$(zoxide init zsh)"
export PATH="$PATH:$(npm get prefix)/bin"

. "$HOME/.local/bin/env"

# bun completions
[ -s "/Users/thongnguyen/.bun/_bun" ] && source "/Users/thongnguyen/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export ANTHROPIC_MODEL="claude-opus-4-8"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
export FLYWAY_DIR=/opt/homebrew/opt/flyway/libexec
alias pio="$HOME/.platformio/penv/bin/pio"
alias lich="curl lich.day"
alias lichthang="curl lich.day/\$(date +%Y%m)"

# completion system (needed for compdef below)
autoload -Uz compinit && compinit -C

# ---- kitty sessions ----
export KITTY_SESSIONS="$HOME/.config/kitty/sessions"
# list saved sessions
sls() {
  local names=("$KITTY_SESSIONS"/*.kitty-session(N:t:r))
  (( ${#names} )) && print -l "${names[@]}" || echo "no sessions"
}
# remove a session by name:  rms dev   (rms <TAB> completes names)
rms() {
  [[ -z $1 ]] && { echo "usage: rms <name>"; return 1; }
  local f="$KITTY_SESSIONS/$1.kitty-session"
  [[ -f $f ]] || { echo "no such session: $1"; return 1; }
  rm -v "$f"
}
# tab-completion of session names for rms
_rms() { compadd -- "$KITTY_SESSIONS"/*.kitty-session(:t:r) }
compdef _rms rms


# Added by Antigravity CLI installer
export PATH="/Users/thongnguyen/.local/bin:$PATH"
