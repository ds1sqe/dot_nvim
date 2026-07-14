## Architecture

### Entry Point & Bootstrap
- `init.lua`: Sets leader key to space, loads `boot.lua`
- `lua/boot.lua`: Bootstraps lazy.nvim and loads plugin specs from `plugins/` directories

### Configuration Structure
```
lua/
├── boot.lua              # lazy.nvim setup and plugin loading
├── config/
│   ├── options.lua       # Vim options (2-space indent, relative numbers, etc.)
│   ├── keymaps.lua       # Global keymaps (disables some defaults like q, gcc)
│   ├── autocmds.lua      # Auto commands (yank highlight, last position, etc.)
│   ├── types.lua         # Global blacklists for filetypes/buftypes
│   ├── ui/               # UI configuration (icons, theme)
│   ├── lsp/
│   │   ├── servers.lua   # LSP server configurations
│   │   ├── setups.lua    # Custom LSP setup functions
│   │   └── keymaps.lua   # LSP-specific keymaps
│   └── extra/            # Extra configurations (nvim-cmp, dict, mini_ai)
├── plugins/              # Core plugin specs
│   ├── lsp.lua           # mason + nvim-lspconfig
│   ├── coding.lua        # Completion, snippets, auto-pairs
│   ├── editor.lua        # Neo-tree, Telescope, which-key, gitsigns
│   ├── dap.lua           # nvim-dap debugging configuration
│   ├── formatter.lua     # conform.nvim formatting
│   └── ai.lua            # avante.nvim AI integration
└── plugins/extras/
    ├── lang/             # Language-specific configs (rust, lua, java, etc.)
    └── ui/               # Additional UI plugins
```

### Plugin Loading
Plugins are organized in `plugins/` with lazy-loading via events, commands, or filetypes. The `plugins/extras/lang/` directory contains language-specific setups that are auto-imported.

### LSP Configuration Pattern
LSP servers are defined in `config/lsp/servers.lua` as a table mapping server names to their configs. Custom setup functions go in `config/lsp/setups.lua`. Mason handles installation, mason-lspconfig bridges to lspconfig.

### Key Patterns
- Leader: `<Space>`
- Most plugins lazy-load on specific keys (check `keys = {}` in plugin specs)
- `util.get_root()` finds project root via LSP workspaces or `.git`
- Global `Blacklist` table in `config/types.lua` defines ignored filetypes/buftypes

## Key Bindings Reference

### File Navigation
- `<leader>e` - Toggle Neo-tree (project root)
- `<leader>fp` - Telescope project picker
- `<leader>fP` - Find file in plugin directory

### LSP
- `K` - Hover documentation
- `gk` - Signature help
- `<leader>ca` - Code action
- `<leader>cr` - Rename (uses inc-rename if available)
- `<leader>cd` - Line diagnostics
- `]d`/`[d` - Next/prev diagnostic
- `]e`/`[e` - Next/prev error

### Debug (DAP)
- `<leader>db` - Toggle breakpoint
- `<leader>dl` - Load .vscode/launch.json (run this first)
- `<leader>dc` - Start/continue debug
- `<leader>do` - Step over
- `<leader>di` - Step into
- `<leader>du` - Toggle DAP UI

### Git (Gitsigns)
- `]h`/`[h` - Next/prev hunk
- `<leader>ghs` - Stage hunk
- `<leader>ghr` - Reset hunk
- `<leader>ghp` - Preview hunk

### Formatting
- `<leader>cf` - Format code (conform.nvim)
- Auto-format disabled by default (`vim.g.autoformat = false`)

## DAP Configuration

Debug configurations are loaded from `.vscode/launch.json` (VS Code compatible). The config auto-loads when entering a buffer if the file exists.

Example `.vscode/launch.json`:
```json
{
  "version": "0.2.0",
  "configurations": [
    {
      "type": "codelldb",
      "request": "launch",
      "name": "Debug Rust",
      "program": "${workspaceFolder}/target/debug/myapp",
      "cwd": "${workspaceFolder}"
    },
    {
      "type": "cppdbg",
      "request": "launch",
      "name": "Debug C/C++ (cpptools)",
      "program": "${workspaceFolder}/build/myapp",
      "MIMode": "lldb",
      "cwd": "${workspaceFolder}"
    },
    {
      "type": "debugpy",
      "request": "launch",
      "name": "Debug Python",
      "program": "${file}",
      "cwd": "${workspaceFolder}"
    },
    {
      "type": "coreclr",
      "request": "launch",
      "name": "Debug F#/C#",
      "program": "${workspaceFolder}/bin/Debug/net8.0/myapp.dll",
      "cwd": "${workspaceFolder}"
    }
  ]
}
```

Supported debug types (VS Code compatible):
- `codelldb` - C, C++, Rust (requires codelldb via Mason, recommended)
- `cppdbg` - C, C++ (requires cpptools/OpenDebugAD7 via Mason)
- `lldb` - C, C++, Rust (requires lldb-dap, fallback)
- `debugpy` - Python (requires debugpy via nvim-dap-python)
- `coreclr` - F#, C# (requires netcoredbg via Mason)
- `nlua` - Neovim Lua (requires one-small-step-for-vimkind)

Predefined variables for launch.json:
- `${workspaceFolder}` - project root path (e.g., `/home/user/project`)
- `${workspaceFolderBasename}` - project folder name (e.g., `project`)
- `${file}` - current file full path
- `${fileWorkspaceFolder}` - workspace folder of current file
- `${relativeFile}` - file path relative to workspaceFolder
- `${relativeFileDirname}` - file's directory relative to workspaceFolder
- `${fileBasename}` - current filename with extension
- `${fileBasenameNoExtension}` - filename without extension
- `${fileDirname}` - current file's directory full path
- `${fileDirnameBasename}` - current file's directory name
- `${fileExtname}` - current file's extension (e.g., `.fs`)
- `${cwd}` - current working directory
- `${lineNumber}` - cursor line number
- `${selectedText}` - selected text in editor
- `${userHome}` - user home directory
- `${env:VAR_NAME}` - environment variable (e.g., `${env:HOME}`)

## Formatters

Configured in `plugins/formatter.lua`:
- Lua: stylua
- Rust: rustfmt
- JavaScript: prettierd/prettier
- Python: ruff_format (fallback: isort + black)
