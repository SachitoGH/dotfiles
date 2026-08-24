# Dotfiles

Small, cross-platform terminal setup managed with
[chezmoi](https://www.chezmoi.io/).

- **Shell:** zsh, zinit, Powerlevel10k, vi mode, and fzf-tab
- **Editor:** Neovim using native `vim.pack`, LSP, blink.cmp, Treesitter,
  fzf-lua, Oil, mini.nvim, and gitsigns
- **Terminal:** tmux, TPM, vim-tmux-navigator, and OS-aware clipboard support
- **Platforms:** Ubuntu, WSL, macOS, and Termux

## Install on a new machine

For a public GitHub repository:

```sh
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply SachitoGH
```

For a private repository after configuring an SSH key:

```sh
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply git@github.com:SachitoGH/dotfiles.git
```

The first apply installs system packages, Neovim, tmux, zinit, TPM, and the
configured tmux plugins. When it finishes, follow the printed `chsh` command if
zsh is not already your login shell, then open zsh once to install its plugins.

## Daily use

| Command | Purpose |
|---|---|
| `chezmoi status` | Show differences between source and home directory |
| `chezmoi diff` | Review changes before applying them |
| `chezmoi re-add <path>` | Copy destination edits back into the source state |
| `chezmoi apply` | Apply the source state locally |
| `chezmoi update` | Pull remote changes and apply them |
| `nvim-sync` | Synchronize Neovim edits, additions, and deletions |

Git add, commit, and push are enabled automatically in the generated chezmoi
configuration.
