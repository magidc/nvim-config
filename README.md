# magidc NVIM Configuration

This is my personal LUA based configuration for Neovim that I use on a daily basis as Java IDE. This setup is the product of continuous enhancements based in what I have found in configurations shared by other users. It is an ongoing project that may evolve with time as I come accross with new plugins, refine mappings or refactor configuration files.<br>Feel free to fork this repository and adapt it to your own needs.

<br>

*Neovim Java autocompletion*
![lsp autocompletion](https://github.com/magidc/nvim-config/blob/master/nvim_lsp_1.png?raw=true)

*Neovim Java errors*
![lsp autocompletion](https://github.com/magidc/nvim-config/blob/master/nvim_lsp_2.png?raw=true)

*Neovim Java debug*
![lsp autocompletion](https://github.com/magidc/nvim-config/blob/master/nvim_debug.png?raw=true)

*Telescope fuzzy finder*
![telecope usage](https://github.com/magidc/nvim-config/blob/master/nvim_telescope.png?raw=true)

# Installation
## Manual Setup
0. Install latest [NeoVIM version](https://github.com/neovim/neovim/wiki/Installing-Neovim). 
1. Packer.nvim plugin manager is required for this setup. Please follow [official install instructions](https://github.com/wbthomason/packer.nvim#quickstart).
2. Clone this repository into `~/.config/nvim`:
    ```
    git clone https://github.com/magidc/nvim-config.git ~/.config/nvim
    ```
4. Install [ripgrep](https://github.com/BurntSushi/ripgrep) into your OS. It is required by some [Telescope](https://github.com/nvim-telescope/telescope.nvim) plugin searching modes.
3. Run `nvim` and execute `:PackerInstall` command to install the plugins.<br>
    > There is a chance that the download would timeout and `packer.nvim` would report install failed, in this case run `:PackerInstall` again.
4. As this Neovim environment is designed mostly to be used as Java IDE, only Java LSP is configured by default. Neovim native LSP support is handled by the [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) plugin (see [jdtls.lua](https://github.com/magidc/nvim-config/blob/master/lua/lsp/configs/jdtls.lua)). As external Java LSP server is required to provide IDE features to the editor, this setup relies on [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer/), just run `:LspInstall jdtls` and the server will be downloaded into configured location.
5. If you want to provide LSP support for more languages, add [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) plugin to your configuration. It manages to configure most of the LSP server options out of the box, all is needed is to install the LSP servers themselves. A complete list of supported LSP servers is listed [here](https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md).<br>
Make sure also that after LSP installation, Treesitter support is added by running  `:TSInstall <lang>`.

## Auto install
> TODO
 
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

# Supported programming languages by default
## Java
Current setup is designed mostly to be used as Java IDE. Neovim native LSP support is handled by the [nvim-jdtls](https://github.com/mfussenegger/nvim-jdtls) plugin (see [jdtls.lua](https://github.com/magidc/nvim-config/blob/master/lua/lsp/configs/jdtls.lua)). As external Java LSP server is required to provide IDE features to the editor, this setup relies on [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer/), just run `:LspInstall jdtls` and the server will be downloaded into configured location.

<br>

# Troubleshooting
If you have problems while installing or using this setup, please report an issue, 

<br>

# Contributing
By the moment, free contribution is not allowed. I consider this setup to be on its early stages so it requires to be more mature before opening to other users. However I would appreciate suggestions.

