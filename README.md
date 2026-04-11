# dotfiles

Terminal setup built around Neovim, tmux, and zsh — managed with [chezmoi](https://www.chezmoi.io).

- **Shell** — zsh with zinit, Powerlevel10k, vi mode, fzf-tab completion
- **Editor** — Neovim (lazy.nvim) with LSP, blink-cmp, Treesitter, Telescope, Diffview
- **Terminal** — tmux with TPM, vim-tmux-navigator, OS-aware clipboard
- **Dotfile sync** — chezmoi with auto git add/commit/push on every change

Works on WSL, Ubuntu, macOS, and Termux.

## Bootstrap a new machine

Install chezmoi and apply dotfiles in one command:

```sh
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply git@github.com:SachitoGH/dotfiles.git
```

This will:
1. Install chezmoi
2. Clone this repo
3. Apply all dotfiles
4. Run the install script (installs packages, tools, etc.)

## Daily use

| Command | What it does |
|---|---|
| `chezmoi re-add` | Sync edits to already-tracked files → commit → push |
| `chezmoi add <path>` | Track a new file or pick up new files in a directory |
| `chezmoi status` | See what's changed / untracked |
| `chezmoi diff` | Preview what `chezmoi apply` would change |
