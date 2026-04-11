# Neovim 0.12 Config Reference

## Plugins

| Plugin | Purpose |
|--------|---------|
| nightfox.nvim | Carbonfox colorscheme |
| blink.cmp | Completion (LSP, snippets, path, buffer, dadbod) |
| vim-dadbod-completion | SQL completion source for blink |
| conform.nvim | Code formatting (manual, `<leader>f`) |
| dial.nvim | Smart increment/decrement (booleans, dates, hex) |
| diffview.nvim | Git diff/merge viewer |
| fzf-lua | Fuzzy finder (files, grep, LSP, buffers) |
| gitsigns.nvim | Git gutter signs, hunk actions, blame |
| lazydev.nvim | Neovim Lua API completions |
| live-preview.nvim | HTML/Markdown live browser preview |
| nvim-lspconfig | LSP server config defaults |
| mason.nvim + mason-lspconfig | Auto-install LSP servers |
| mini.nvim | ai, surround, move, pairs, hipatterns, statusline, icons |
| oil.nvim | Floating file explorer |
| vim-tmux-navigator | Seamless tmux/vim pane navigation |
| nvim-treesitter | Parser installer (highlight/indent are built-in) |
| nvim-treesitter-textobjects | Textobject move/swap |
| nvim-treesitter-context | Sticky function/class context header |
| nvim-ts-autotag | Auto-close/rename HTML/JSX tags |

LSP servers: clangd, pyright, html, cssls, angularls, emmet_ls, lua_ls, ts_ls

## Keybindings

### Navigation (`<C->`)

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate tmux/vim panes |
| `<C-\>` | Navigate to previous pane |
| `<C-a/x>` | Increment/decrement (dial) |

### Search (`<leader>s`)

| Key | Action |
|-----|--------|
| `sf` | Search files |
| `sg` | Live grep |
| `sw` | Search word under cursor |
| `sh` | Search help tags |
| `sk` | Search keymaps |
| `sd` | Search diagnostics |
| `sr` | Resume last search |
| `ss` | Browse fzf-lua pickers |
| `sn` | Search neovim config |
| `s.` | Search recent files |
| `s/` | Live grep in open files |

| Key | Action |
|-----|--------|
| `<leader>/` | Fuzzy search in buffer |
| `<leader><leader>` | Switch buffer |

### Git Hunks (`<leader>h`)

| Key | Action |
|-----|--------|
| `hs/hr` | Stage/reset hunk |
| `hS/hR` | Stage/reset buffer |
| `hu` | Undo staged hunk |
| `hp` | Preview hunk |
| `hb` | Blame line |
| `hd/hD` | Diff against index/last commit |

### Git Diff (`<leader>g`)

| Key | Action |
|-----|--------|
| `gd` | Open diff view |
| `gD` | Close diff view |
| `gt` | Toggle diff file panel |

### Toggle (`<leader>t`)

| Key | Action |
|-----|--------|
| `tb` | Git: Toggle blame line |
| `tD` | Git: Toggle deleted lines |
| `tv` | LSP: Toggle virtual text |

### Misc (`<leader>`)

| Key | Action |
|-----|--------|
| `o` | Toggle file explorer |
| `u` | Toggle undo tree |
| `d` | LSP: Show diagnostics |
| `f` | Format buffer |
| `ap/aP` | Swap with next/prev parameter |

### LSP (`gr` prefix)

| Key | Action |
|-----|--------|
| `grr` | Go to references |
| `gri` | Go to implementation |
| `grd` | Go to definition |
| `grD` | Go to declaration |
| `grt` | Go to type definition |
| `grn` | Rename (built-in) |
| `gra` | Code action (built-in) |
| `grx` | Codelens run (built-in) |
| `gO` | Document symbols |
| `gW` | Workspace symbols |
| `K` | Hover (built-in) |
| `<C-S>` | Signature help, insert mode (built-in) |

### Jump (`]`/`[` + key)

| Key | Object |
|-----|--------|
| `]/[` + `]`/`[` | Function (start/end) |
| `c/C` | Class (start/end) |
| `i/I` | Conditional (start/end) |
| `l/L` | Loop (start/end) |
| `g` | Git hunk |

### Surround (`s` prefix)

| Key | Action |
|-----|--------|
| `sa` | Add |
| `sd` | Delete |
| `sr` | Replace |
| `sf/sF` | Find right/left |
| `sh` | Highlight |

### Visual Mode

| Key | Action |
|-----|--------|
| `H/J/K/L` | Move selection |

### Commands

| Command | Action |
|---------|--------|
| `:Format` | Format buffer/selection (conform) |
| `:LspInfo` | LSP health check |
| `:LspRestart` | Restart LSP servers |
| `:LspLog` | Open LSP log |
| `:Mason` | Manage LSP server installations |
