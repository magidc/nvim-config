# magidc NVIM Configuration

This is my personal LUA based configuration for Neovim that I use on a daily basis as Java, Python and RUST IDE. This setup is the product of continuous enhancements based in what I have found in configurations shared by other users. It is an ongoing project that may evolve with time as I come accross with new plugins, refine mappings or refactor configuration files.<br>Feel free to fork this repository and adapt it to your own needs.

<br>

*Autocompletion*
![lsp autocompletion](https://github.com/magidc/nvim-config/blob/master/screenshots/nvim_lsp_1.png?raw=true)

*Compilation errors*
![lsp autocompletion](https://github.com/magidc/nvim-config/blob/master/screenshots/nvim_lsp_2.png?raw=true)

*Debug*
![lsp autocompletion](https://github.com/magidc/nvim-config/blob/master/screenshots/nvim_debug.png?raw=true)

*Running Spring boot*
![lsp autocompletion](https://github.com/magidc/nvim-config/blob/master/screenshots/run.png?raw=true)

*Telescope fuzzy finder*
![telecope usage](https://github.com/magidc/nvim-config/blob/master/screenshots/nvim_telescope.png?raw=true)

# Installation
## Manual Setup
0. Install latest [NeoVIM version](https://github.com/neovim/neovim/wiki/Installing-Neovim). 
1. Clone this repository into `~/.config/nvim`:
    ```
    git clone https://github.com/magidc/nvim-config.git ~/.config/nvim
    ```
2. Install [ripgrep](https://github.com/BurntSushi/ripgrep) into your OS. It is required by some [Telescope](https://github.com/nvim-telescope/telescope.nvim) plugin searching modes.
3. Run `nvim` and execute `:PackerInstall` command to install the plugins.<br>
    > There is a chance that the download would timeout and `packer.nvim` would report install failed, in this case run `:PackerInstall` again.<br>
    > Some plugins may not be able to complete installation in a fresh Neovim environment as there may be some dependencies between them. In that case, just run `:TSUpdate` on the next Neovim start.

4. This environment is configured with several Language Server Providers (LSP) for Java, Python, Rust and Lua. All of them are integrated with Neovim native LSP support. It is required to install LSP in your system in order to have IDE features like autocompletions or error highlight. Other language related features are also provided by Treesitter. To download and setup LSPs in you system, this configuration relies on [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer/) plugin:
   1. Java: Run `:LspInstall jdtls` to download LSP to `~/.local/share/nvim/lsp_servers/jdtls`. This environment expects to find the server executables in that location, if different one is choosen, edit [jdtls.lua](https://github.com/magidc/nvim-config/blob/master/lua/lsp/configs/jdtls.lua) and set the proper location of the LSP.
   2. Rust: Run `:LspInstall rust_analyzer` to download LSP to `~/.local/share/nvim/lsp_servers/rust`. This environment expects the contents of this directory to be accesible, make sure you add it to PATH variable.
   3. Lua: Run `:LspInstall sumneko_lua` to download LSP to `~/.local/share/nvim/lsp_servers/sumneko_lua`. This environment expects to find the server executables in that location, if different one is choosen, edit [init.lua](https://github.com/magidc/nvim-config/blob/master/lua/lsp/init.lua) and change variable  sumneko_root_path to the proper location.
   4. Python: Run `:LspInstall pyright` to download LSP to `~/.local/share/nvim/lsp_servers/python`. This environment expects the contents of this directory to be accesible, make sure you add it to PATH variable.
   
<br>

# UI theme
Several UI themes are preconfigured in this setup. Active theme is set by editing file `lua/settings.lua`.
Default active theme is [Tokyonight](https://github.com/folke/tokyonight.nvim).

<br>

# Custom mappings
Most of mappings are defined in file `lua/mappings.lua`. WhichKey plugin is used in order to provide a description for each one of them.
Other mappings can be found in specific plugin configuration files in `lua/plugins/configs` directory.
Note that the config uses `SPACE` as the leader key by default, you can change it in `lua/settings.lua`, line `57`

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
* [Tokyonight UI theme](https://github.com/folke/tokyonight.nvim)
* Others...

<br>

# Troubleshooting
If you have problems while installing or using this setup, please report an issue, 

<br>

# Contributing
By the moment, free contribution is not allowed. I consider this setup to be on its early stages so it requires to be more mature before opening to other users. However I would appreciate suggestions.

