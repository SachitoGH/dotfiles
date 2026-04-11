#!/usr/bin/env bash
# Bootstrap — runs once on `chezmoi apply` (re-runs only if this file changes)
# Supports: WSL, Ubuntu, macOS, Termux

set -e

log() { printf '\033[1;34m>> %s\033[0m\n' "$*"; }
ok()  { printf '\033[1;32m✓  %s\033[0m\n' "$*"; }

MARKER="${XDG_DATA_HOME:-$HOME/.local/share}/.dotfiles-bootstrapped"
if [[ -f "$MARKER" ]]; then
  ok "Already bootstrapped, skipping. Remove $MARKER to re-run."
  exit 0
fi

is_termux() { [[ -d /data/data/com.termux ]]; }
is_macos()  { [[ "$(uname)" == "Darwin" ]]; }
is_wsl()    { grep -qi microsoft /proc/version 2>/dev/null; }

# ── Homebrew ──────────────────────────────────────────────────────────────────
brew_setup() {
  if ! command -v brew &>/dev/null; then
    log "Installing Homebrew..."
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  # Ensure brew is in PATH for the rest of this script
  for dir in /opt/homebrew /home/linuxbrew/.linuxbrew /usr/local; do
    [[ -x "$dir/bin/brew" ]] && eval "$("$dir/bin/brew" shellenv)" && break
  done
}

# ── Termux ────────────────────────────────────────────────────────────────────
install_termux() {
  log "Termux detected"
  pkg update -y
  pkg install -y \
    git zsh tmux neovim \
    fzf ripgrep fd-find \
    nodejs python \
    make unzip \
    clang clangd lua-language-server
}

# ── macOS ─────────────────────────────────────────────────────────────────────
install_macos() {
  log "macOS detected"
  brew_setup
  brew install \
    git zsh tmux neovim \
    fzf ripgrep fd \
    git-delta stylua \
    node python3 \
    make unzip
}

# ── Linux (Ubuntu / WSL) ──────────────────────────────────────────────────────
install_linux() {
  log "Linux detected"
  sudo apt-get update -y
  sudo apt-get install -y \
    git zsh curl \
    make gcc unzip \
    python3 python3-pip \
    nodejs npm \
    ripgrep fd-find \
    fzf

  brew_setup
  # apt versions are too old for these — install via brew
  brew install neovim tmux git-delta stylua

  # WSL: clipboard bridge
  if is_wsl; then
    log "WSL detected"
    if ! command -v win32yank.exe &>/dev/null; then
      log "win32yank not found — install it for clipboard support:"
      log "  Download win32yank from https://github.com/equalsraf/win32yank/releases"
      log "  then move win32yank.exe to /usr/local/bin/"
    else
      ok "win32yank already installed"
    fi
  fi
}

# ── Dispatch ──────────────────────────────────────────────────────────────────
if is_termux; then
  install_termux
elif is_macos; then
  install_macos
else
  install_linux
fi

touch "$MARKER"
ok "Bootstrap complete — open a new shell to apply changes"
