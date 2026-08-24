#!/usr/bin/env bash
# Idempotent bootstrap for Ubuntu/WSL, macOS, and Termux.
# Chezmoi reruns this run_once_ script whenever its contents change.

set -euo pipefail

log() { printf '\033[1;34m>> %s\033[0m\n' "$*"; }
ok() { printf '\033[1;32m✓  %s\033[0m\n' "$*"; }

is_termux() { [[ -d /data/data/com.termux ]]; }
is_macos() { [[ "$(uname -s)" == "Darwin" ]]; }
is_wsl() { grep -qi microsoft /proc/version 2>/dev/null; }

brew_setup() {
  if ! command -v brew &>/dev/null; then
    log "Installing Homebrew"
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  local prefix
  for prefix in /opt/homebrew /home/linuxbrew/.linuxbrew /usr/local; do
    if [[ -x "$prefix/bin/brew" ]]; then
      eval "$("$prefix/bin/brew" shellenv)"
      return
    fi
  done

  printf 'Homebrew was installed but could not be found.\n' >&2
  return 1
}

install_termux() {
  log "Installing Termux packages"
  pkg update -y
  pkg install -y \
    git zsh tmux neovim \
    fzf ripgrep fd \
    nodejs python \
    make unzip \
    clang clangd lua-language-server
}

install_macos() {
  log "Installing macOS packages"
  brew_setup
  brew install \
    git tmux neovim \
    fzf ripgrep fd \
    git-delta stylua \
    node python3
}

install_linux() {
  if ! command -v apt-get &>/dev/null; then
    printf 'This bootstrap currently supports Debian/Ubuntu-based Linux only.\n' >&2
    return 1
  fi

  log "Installing Linux packages"
  sudo apt-get update -y
  sudo apt-get install -y \
    build-essential ca-certificates curl file git procps zsh unzip \
    python3 python3-pip nodejs npm \
    ripgrep fd-find fzf \
    wl-clipboard xclip

  brew_setup
  # Distribution packages can lag behind the versions required by this config.
  brew install neovim tmux git-delta stylua

  if is_wsl && ! command -v win32yank.exe &>/dev/null; then
    log "Optional WSL clipboard support: install win32yank.exe in PATH"
  fi
}

clone_if_missing() {
  local repository=$1
  local destination=$2

  if [[ ! -d "$destination/.git" ]]; then
    log "Installing $(basename "$destination")"
    mkdir -p "$(dirname "$destination")"
    git clone --depth=1 "$repository" "$destination"
  fi
}

install_shell_plugins() {
  local data_home=${XDG_DATA_HOME:-$HOME/.local/share}
  clone_if_missing \
    https://github.com/zdharma-continuum/zinit.git \
    "$data_home/zinit/zinit.git"
}

install_tmux_plugins() {
  local plugin_home=$HOME/.tmux/plugins
  clone_if_missing \
    https://github.com/tmux-plugins/tpm \
    "$plugin_home/tpm"
  clone_if_missing \
    https://github.com/christoomey/vim-tmux-navigator \
    "$plugin_home/vim-tmux-navigator"
  clone_if_missing \
    https://github.com/vaaleyard/tmux-dotbar \
    "$plugin_home/tmux-dotbar"
}

if is_termux; then
  install_termux
elif is_macos; then
  install_macos
else
  install_linux
fi

install_shell_plugins
install_tmux_plugins

ok "Bootstrap complete"
if [[ ${SHELL:-} != "$(command -v zsh)" ]]; then
  log "To make zsh your login shell, run: chsh -s $(command -v zsh)"
fi
log "Open zsh once to install the configured zinit plugins"
