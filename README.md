# Neovim configuration for Java, Python, Rust and Lua

This is my personal LUA based configuration for Neovim that I use on a daily basis as Java, Python and RUST IDE. This setup is the product of continuous enhancements based in what I have found in configurations shared by other users. It is an ongoing project that may evolve with time as I come accross with new plugins, refine mappings or refactor configuration files.<br>Feel free to fork this repository and adapt it to your own needs.

<br>

*Autocompletion*
![lsp autocompletion](./screenshots/nvim_lsp_cmp.png?raw=true)

*Compilation errors*
![lsp autocompletion](./screenshots/nvim_lsp_errors.png?raw=true)

*Debug*
![lsp autocompletion](./screenshots/nvim_dap.png?raw=true)

*Launching Java application*
![lsp autocompletion](./screenshots/nvim_java_launch.png?raw=true)

*Telescope fuzzy finder*
![telecope usage](./screenshots/nvim_telescope.png?raw=true)

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

4. This environment is configured with Language Server Providers (LSP) for Java, Python, Rust and Lua. All of them are integrated with Neovim native LSP support. It is required to install LSP in your system in order to have IDE features like autocompletions or error highlight. To facilitate installation of LSPs this configuration relies on [mason.nvim](https://github.com/williamboman/mason.nvim#installation) plugin. Download location is set to `~/.local/share/nvim/mason/packages` but it can be changed by editing global variable `LSP_ROOT_PATH` on file [mason.lua](https://github.com/magidc/nvim-config/blob/master/lua/plugins/configs/mason.lua). Find below the instructions to setup each one of the supported LSPs:
   1. **Java**: Run `:MasonInstall jdtls` to download LSP to `LSP_ROOT_PATH/jdtls`. This environment expects to find the server executables in that location, if different one is required just edit [jdtls.lua](https://github.com/magidc/nvim-config/blob/master/lua/lsp/configs/jdtls.lua) and set proper location of the LSP. Make also sure to set the `java_cmd` path in the config file. You will need also to enable debugging via [java-debug](https://github.com/microsoft/java-debug) and test debug via [vscode-java-test](https://github.com/microsoft/vscode-java-test). More instructions in Kevin Sookocheff [website](https://sookocheff.com/post/vim/neovim-java-ide/#debugging--nvim-dap) 
   2. **Rust**: Run `:MasonInstall rust_analyzer` to download LSP to `LSP_ROOT_PATH/rust_analyzer`. This environment expects to find the server executables in that location, if different one is required just edit [init.lua](https://github.com/magidc/nvim-config/blob/master/lua/lsp/init.lua) and change Rust LSP settings `cmd` property to proper location.
   3. **Lua**: Run `:MasonInstall lua-language-server` to download LSP to `LSP_ROOT_PATH/lua-language-server`. This environment expects to find the server executables in that location, if different one is required just edit [init.lua](https://github.com/magidc/nvim-config/blob/master/lua/lsp/init.lua) and change Lua LSP settings `cmd` property to proper location.
   4. **Python**: Run `:MasonInstall pyright` to download LSP to `LSP_ROOT_PATH/pyright`.This environment expects to find the server executables in that location, if different one is required just edit [init.lua](https://github.com/magidc/nvim-config/blob/master/lua/lsp/init.lua) and change Pyright LSP `cmd` property to proper location.
   <!-- 5. **Bash**: Run `:MasonInstall bash-language-server` to download LSP to `LSP_ROOT_PATH/bash-language-server`.This environment expects to find the server executables in that location, if different one is required just edit [init.lua](https://github.com/magidc/nvim-config/blob/master/lua/lsp/init.lua) and change Bash LSP `cmd` property to proper location.   -->
   <!-- 6. **HTML, CSS, JSON, JavaScript, TypeScript, Markdown**: Run `:MasonInstall html-lsp` to download LSP to `LSP_ROOT_PATH/html-lsp`.This environment expects to find the server executables in that location, if different one is required just edit [init.lua](https://github.com/magidc/nvim-config/blob/master/lua/lsp/init.lua) and change LSPs `cmd` property to proper location. -->
   <!-- 7. **Dockerfile**: Run `:MasonInstall dockerfile-language-server` to download LSP to `LSP_ROOT_PATH/dockerfile-language-server`.This environment expects to find the server executables in that location, if different one is required just edit [init.lua](https://github.com/magidc/nvim-config/blob/master/lua/lsp/init.lua) and change LSPs `cmd` property to proper location. -->
<br>

# UI theme
Several UI themes are preconfigured in this setup. Active theme is set by editing file `lua/settings.lua`.
Default active theme is [Onedark](https://github.com/navarasu/onedark.nvim).

<br>

# Custom mappings
Most of mappings are defined in file `lua/mappings.lua`. WhichKey plugin is used in order to provide a description for each one of them.
Other mappings can be found in specific plugin configuration files in `lua/plugins/configs` directory.

<br>

# Equivalent mapping configurations for other IDEs VIM integrations
I have created configuration files with (almost) equivalent mappings for [Eclipse IDE vim plugin (vrapper)](https://github.com/magidc/dotfiles/blob/master/.vrapperrc), [IntelliJ vim plugin (ideaVim)](https://github.com/magidc/dotfiles/blob/master/.ideavimrc) and [VIM (.vimrc)](https://github.com/magidc/dotfiles/blob/master/.vimrc).
For VSCode VIM plugin I set the option to use .vimrc config file.
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
If you have problems while installing or using this setup, please report an issue, 

<br>

# Contributing
By the moment, free contribution is not allowed. I consider this setup to be on its early stages so it requires to be more mature before opening to other users. However I would appreciate suggestions.

