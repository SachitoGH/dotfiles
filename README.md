# Dotfiles

Small, cross-platform terminal setup managed with
[chezmoi](https://www.chezmoi.io/).

- **Shell:** zsh, zinit (turbo-loaded plugins), Powerlevel10k, fzf, and fzf-tab
- **Editor:** Neovim using native `vim.pack`, LSP, blink.cmp, Treesitter,
  fzf-lua, Oil, mini.nvim, and gitsigns
- **Terminal:** tmux, TPM, vim-tmux-navigator, and portable clipboard support
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

The first apply installs the minimal system packages, Neovim, the configured
npm tools, zinit, TPM, and the tmux plugins. WSL clipboard support is installed
automatically. When it finishes, follow the printed `chsh` command if zsh is not
already your login shell, then open zsh once to install its plugins.

## Daily use

| Command | Purpose |
|---|---|
| `chezmoi status` | Show differences between source and home directory |
| `chezmoi diff` | Review changes before applying them |
| `chezmoi re-add <path>` | Copy destination edits back into the source state |
| `chezmoi apply` | Apply the source state locally |
| `chezmoi update` | Pull remote changes and apply them |

Git add, commit, and push are enabled automatically in the generated chezmoi
configuration.
