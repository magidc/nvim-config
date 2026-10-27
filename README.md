# Neovim configuration for Java, Python, Rust and Lua

This is my personal LUA based configuration for Neovim that I use on a daily basis as Java, Python and RUST IDE. This setup is the product of continuous enhancements based in what I have found in configurations shared by other users. It is an ongoing project that may evolve with time as I come accross with new plugins, refine mappings or refactor configuration files.<br>Feel free to fork this repository and adapt it to your own needs.

<br>

*Autocompletion*
![lsp autocompletion](./screenshots/nvim_lsp_cmp.png?raw=true)

*Compilation errors*
![lsp errors](./screenshots/nvim_lsp_errors.png?raw=true)

*Debug*
![dap debugging](./screenshots/nvim_dap.png?raw=true)

*Launching Java application*
![java launch](./screenshots/nvim_java_launch.png?raw=true)

*Telescope fuzzy finder*
![telescope usage](./screenshots/nvim_telescope.png?raw=true)

# Installation
## Automatic setup (APT based distributions: Debian, Ubuntu, Pop!_OS...)
[install_nvim.sh](https://github.com/magidc/nvim-config/blob/master/install_nvim.sh) installs Neovim and everything this configuration needs. Run it as your normal user (it asks for `sudo` for system packages and to install Neovim into `/usr/local`):
```
sudo apt install -y git
git clone --depth 1 https://github.com/magidc/nvim-config.git ~/.config/nvim
bash ~/.config/nvim/install_nvim.sh
```
It is safe to re-run: what is already installed is skipped, Neovim is rebuilt when a new stable release is out and plugins are updated. Steps:
1. System packages: build tools, `ripgrep`, `fd-find`, `zoxide`, `xclip`/`wl-clipboard`, `zsh`, `tidy`, `xmllint`, `python3-venv`, `unzip`...
2. Latest stable Neovim built from source into `/usr/local` (`NVIM_REF=<tag or branch>` builds another one).
3. Node.js LTS with [nvm](https://github.com/nvm-sh/nvm) unless node >= 22 is already there, Rust with [rustup](https://rustup.rs) and the [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) with `cargo`.
4. [FiraCode Nerd Font](https://www.nerdfonts.com) into `~/.local/share/fonts`.
5. This repository into `~/.config/nvim` if there is no config yet (`CONFIG_REPO=<url>` clones a fork).
6. Plugins (`:Lazy! sync`), treesitter parsers and [Mason](https://github.com/mason-org/mason.nvim) packages (LSP servers, debug adapters, formatters), all headless. The lists are the `ensure_installed` options in `lua/plugins/configs/treesitter.lua` and `lua/plugins/configs/mason.lua` (`name@version` pins a version), plus `shellcheck` (bashls lints with it) and the formatters in `lua/plugins/configs/conform.lua` that are not installed yet. Missing Mason packages are installed; update them with `:Mason`. The prebuilt fuzzy matcher library of [blink.cmp](https://github.com/Saghen/blink.cmp) is downloaded too.
7. A [Temurin](https://adoptium.net) JDK from the Adoptium APT repository if the `java` on `PATH` is older than the installed jdtls requires (Java 25 for jdtls 1.63).

Then open a new terminal, set its font to *FiraCode Nerd Font* and start `nvim`. LSP servers are installed but not started automatically: use `:lsp enable <name>` (jdtls starts by itself on Java files), see [Language servers and debugging](#language-servers-and-debugging).

## Manual setup
Requirements: Neovim >= 0.12, git, curl, tar, unzip, a C compiler and make, [tree-sitter CLI](https://github.com/tree-sitter/tree-sitter) >= 0.26.1 (from your package manager, `cargo` or its GitHub releases, not from npm), [ripgrep](https://github.com/BurntSushi/ripgrep), fd, zoxide, a clipboard tool (xclip or wl-clipboard), zsh (terminal), tidy and xmllint (formatters), Node.js >= 22 and npm, python3 with venv, Rust with [rustup](https://rustup.rs) (rust-analyzer needs the `rust-src` component, Rust code is formatted with `rustfmt`), a JDK for jdtls (Java 25 for jdtls 1.63) and a [Nerd Font](https://www.nerdfonts.com). Clone this repository into `~/.config/nvim` and start `nvim`: plugins, treesitter parsers, LSP servers and debug adapters are installed on the first start. Install the formatters and shellcheck (used by bashls) with `:MasonInstall stylua beautysh jq prettierd prettier ruff shellcheck`.

<br>

# Language servers and debugging
The language servers listed in `lua/plugins/configs/mason.lua` (pyright, rust_analyzer, lua_ls, bashls, html, jsonls, clangd...) are installed by [mason.nvim](https://github.com/mason-org/mason.nvim) and configured with `vim.lsp.config()` in `lua/lsp/init.lua`, but they are not started automatically:
* `:lsp enable <name>` (e.g. `:lsp enable pyright`) starts a server for the current buffer and for the next buffers of its filetypes; `:lsp disable <name>` and `:lsp stop` stop it.
* `:checkhealth vim.lsp` shows the enabled servers and the running clients.
* Java is the exception: [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) starts jdtls when a Java file is opened.

Debugging uses [nvim-dap](https://github.com/mfussenegger/nvim-dap) and [nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui). The debug adapters are installed by [mason-nvim-dap](https://github.com/jay-babu/mason-nvim-dap.nvim) (`lua/plugins/configs/mason.lua`):
* Java: java-debug and java-test, loaded into jdtls by nvim-jdtls (`lua/lsp/configs/java.lua`).
* Python: debugpy. Programs run with the python of the active virtualenv or conda environment (`$VIRTUAL_ENV`, `$CONDA_PREFIX`), otherwise with `python3` from `PATH`.
* Rust, C and C++: codelldb.

Code is formatted with [conform.nvim](https://github.com/stevearc/conform.nvim) (`<leader>rf`); the formatters of each filetype are set in `lua/plugins/configs/conform.lua`.

<br>

# Completion
Completion uses [blink.cmp](https://github.com/Saghen/blink.cmp) (`lua/plugins/configs/blink.lua`) with LSP, path, buffer and snippet sources; snippets come from [LuaSnip](https://github.com/L3MON4D3/LuaSnip) and [friendly-snippets](https://github.com/rafamadriz/friendly-snippets). No item is preselected and completion is off inside comments. Keys in Insert mode:
* `<C-n>`/`<C-p>` (or `<Down>`/`<Up>`) select the next/previous item.
* `<Tab>` accepts the item only if one was selected, otherwise it jumps to the next snippet placeholder or inserts a Tab; `<S-Tab>` jumps to the previous placeholder.
* `<CR>` accepts the selected item or, if none is selected, the first one.
* `<C-q>` cancels the completion, `<C-Space>` opens the menu or toggles the documentation window, `<C-b>`/`<C-f>` scroll the documentation.
* `<C-k>` shows/hides the function signature help, which is also shown while typing the arguments.

In the command line the completion menu opens as you type.

<br>

# UI theme
Several UI themes are preconfigured in this setup (`lua/theme.lua`). Active theme is set by editing file `lua/settings.lua`.
Default active theme is [Tokyonight](https://github.com/folke/tokyonight.nvim), which is also used when the theme name is unknown.
Inside tmux the editor background is left transparent, so that the pane colors of tmux show through.

<br>

# Custom mappings
Most of mappings are defined in file `lua/mappings.lua`. WhichKey plugin is used in order to provide a description for each one of them: press the leader key (`Space`) and wait for its popup.
Other mappings can be found in specific plugin configuration files in `lua/plugins/configs` directory. Java-specific mappings are defined in `lua/lsp/configs/java.lua` and are only available once jdtls is attached.
Some features rely on Neovim built-ins: `<leader>vu` opens `:Undotree`, `<leader>vi` opens `:InspectTree`, and `+`/`_` (Neovim's `an`/`in`) expand/shrink the selection to the surrounding syntax node; in Normal mode `+` starts the selection. In files without a treesitter parser, [vim-expand-region](https://github.com/terryma/vim-expand-region) expands through words, quotes, brackets, tags and paragraphs instead. `m` sets marks as in plain Vim, and the leader of [vim-visual-multi](https://github.com/mg979/vim-visual-multi) is `<leader>m`.

<br>

# Equivalent mapping configurations for other IDEs VIM integrations
I have created configuration files with (almost) equivalent mappings for [Eclipse IDE vim plugin (vrapper)](https://github.com/magidc/dotfiles/blob/master/vrapperrc), [IntelliJ vim plugin (ideaVim)](https://github.com/magidc/dotfiles/blob/master/jetbrains/ideavimrc) and [VSCode vim plugin (vscodevim)](https://github.com/magidc/dotfiles/blob/master/vscode/keybindings.json).
These configurations will allow users who are used to these key combinations to remain confortable and efficient while working with other IDEs.

<br>

# Featured plugins
* [Telescope](https://github.com/nvim-telescope/telescope.nvim)
    > Highly extendable fuzzy finder over lists
* [Neotree](https://github.com/nvim-neo-tree/neo-tree.nvim)
    > Tree file explorer 
* [Aerial](https://github.com/stevearc/aerial.nvim)
    > Code outline window for skimming and quick navigation
* [WhichKey](https://github.com/folke/which-key.nvim)
    > Displays a popup with possible key bindings of the command you started typing
* [Nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls)
    > Extensions for the built-in LSP support in Neovim for eclipse.jdt.ls
* [Nvim-dap](https://github.com/mfussenegger/nvim-dap)
    > Debug Adapter Protocol client implementation for Neovim
* Others...

<br>

# Troubleshooting
`:checkhealth` reports missing tools and plugin problems. If you have problems while installing or using this setup, please report an issue.

<br>

# Feedback and suggestions
I would appreciate suggestions and feedback regarding this Neovim configuration. As it is an ongoing project I will be changing over the time to become more useful and easy to use. Please do not hesitate to contact me if you have any comments
