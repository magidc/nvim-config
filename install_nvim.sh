#!/usr/bin/env bash
# Installs Neovim (built from source) and everything this configuration needs on APT based distros
# (Debian, Ubuntu, Pop!_OS...): system packages, Node.js, Rust, tree-sitter CLI, Nerd Font, the config,
# plugins, treesitter parsers, Mason packages (LSP servers, debug adapters, formatters) and a JDK for jdtls.
# Run it as your normal user: sudo is only used for apt and to install Neovim into /usr/local.
# Safe to re-run: what is already there is skipped, Neovim is rebuilt when NVIM_REF points to a new release
# and plugins are updated (:Lazy! sync).
#
# Environment overrides:
#   NVIM_REF     Neovim tag or branch to build (default: stable)
#   CONFIG_REPO  repository cloned when there is no config yet
#   NVM_VERSION  nvm release installed when there is no node >= 22
# The config is cloned where Neovim reads it: ${XDG_CONFIG_HOME:-~/.config}/${NVIM_APPNAME:-nvim}
[ -n "${BASH_VERSION:-}" ] || exec bash "$0" "$@" # also when started as 'sh install_nvim.sh'
set -euo pipefail

NVIM_REF=${NVIM_REF:-stable}
CONFIG_REPO=${CONFIG_REPO:-https://github.com/magidc/nvim-config.git}
NVM_VERSION=${NVM_VERSION:-v0.40.8}

NODE_MIN=22       # engines of the npm based Mason packages
TS_CLI_MIN=0.26.1 # nvim-treesitter (main branch)
NVIM=/usr/local/bin/nvim
CONFIG_DIR=${XDG_CONFIG_HOME:-$HOME/.config}/${NVIM_APPNAME:-nvim}
MASON_DIR=${XDG_DATA_HOME:-$HOME/.local/share}/${NVIM_APPNAME:-nvim}/mason
CARGO_BIN=${CARGO_HOME:-$HOME/.cargo}/bin
NVM_DIR=${NVM_DIR:-${XDG_CONFIG_HOME:+$XDG_CONFIG_HOME/nvm}} # same default as nvm's installer
export NVM_DIR=${NVM_DIR:-$HOME/.nvm}

APT_PACKAGES=(
    build-essential cmake ninja-build gettext curl git ca-certificates # Neovim build (BUILD.md), C compiler for parsers
    unzip python3 python3-venv                                         # Mason: zip/vsix archives, pypi packages
    ripgrep fd-find zoxide zsh tidy libxml2-utils                      # telescope, toggleterm, conform (tidy, xmllint)
    xclip wl-clipboard                                                 # clipboard=unnamedplus on X11 / Wayland
    fontconfig xz-utils                                                # Nerd Font
)

WARNINGS=()
step() { printf '\n\033[1;34m==> %s\033[0m\n' "$*"; }
info() { printf '    %s\n' "$*"; }
warn() { WARNINGS+=("$*"); printf '\033[1;33mWARNING:\033[0m %s\n' "$*" >&2; }
die() { printf '\033[1;31mERROR:\033[0m %s\n' "$*" >&2; exit 1; }
have() { command -v "$1" >/dev/null 2>&1; }
version_ge() { printf '%s\n%s\n' "$2" "$1" | sort -V -C; } # $1 >= $2
curl_get() { curl --proto '=https' --tlsv1.2 -fsSL "$@"; }
# the lock timeout waits for unattended-upgrades, which often holds the dpkg lock right after boot
apt_get() { sudo env DEBIAN_FRONTEND=noninteractive apt-get -o DPkg::Lock::Timeout=600 "$@"; }
apt_install() {
    apt_get update || warn "apt-get update failed (a broken APT source?), using the cached package lists"
    apt_get install -y "$@"
}

[ "$(id -u)" -ne 0 ] || die "run it as your normal user, sudo is used where needed"
have apt-get || die "only APT based distributions are supported"
have sudo || die "sudo is required"
sudo -v || die "your user cannot use sudo"

tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
trap 'exit 130' INT TERM

install_packages() {
    step "System packages"
    local p missing=()
    for p in "${APT_PACKAGES[@]}"; do
        # shellcheck disable=SC2016
        [ "$(dpkg-query -W -f='${Status}' "$p" 2>/dev/null)" = "install ok installed" ] || missing+=("$p")
    done
    if [ ${#missing[@]} -eq 0 ]; then
        info "all installed"
    else
        apt_install "${missing[@]}"
    fi
}

install_neovim() {
    step "Neovim ($NVIM_REF)"
    local src=$tmp/neovim want installed
    git -c advice.detachedHead=false clone --quiet --depth 1 --branch "$NVIM_REF" https://github.com/neovim/neovim "$src"
    want=$(git -C "$src" describe --exact-match 2>/dev/null || git -C "$src" rev-parse --short HEAD)
    installed=$("$NVIM" --version 2>/dev/null | sed -n '1s/^NVIM //p' || true)
    if [ "$installed" = "$want" ]; then
        info "$want is already installed"
    else
        info "building $want (installed: ${installed:-none})"
        make -C "$src" CMAKE_BUILD_TYPE=Release
        # cmake --install only adds files: drop the old runtime and bundled parsers first
        sudo rm -rf /usr/local/share/nvim/runtime /usr/local/lib/nvim
        sudo cmake --install "$src/build"
    fi
    rm -rf "$src"
}

nvm_do() { # nvm.sh is not 'set -euo pipefail' safe
    local rc=0
    set +euo pipefail
    # shellcheck source=/dev/null
    . "$NVM_DIR/nvm.sh" --no-use
    nvm "$@" || rc=$?
    set -euo pipefail
    return "$rc"
}

node_ok() { have node && have npm && [ "$(node -p 'process.versions.node.split(".")[0]' 2>/dev/null)" -ge "$NODE_MIN" ] 2>/dev/null; }

install_node() {
    step "Node.js >= $NODE_MIN"
    if ! node_ok && [ -s "$NVM_DIR/nvm.sh" ]; then
        nvm_do use default >/dev/null 2>&1 || true
    fi
    if ! node_ok; then
        local old=N/A
        if [ -s "$NVM_DIR/nvm.sh" ]; then
            old=$(nvm_do version default 2>/dev/null || true)
        else
            curl_get "https://raw.githubusercontent.com/nvm-sh/nvm/$NVM_VERSION/install.sh" | bash
        fi
        nvm_do install --lts
        nvm_do alias default 'lts/*'
        node_ok || die "node >= $NODE_MIN with npm is still not on PATH"
        [ "${old:-N/A}" = N/A ] || warn "nvm's default node changed from $old to $(node --version)"
    fi
    info "node $(node --version) ($(command -v node))"
}

install_rust() {
    step "Rust (rustup)"
    local env=${CARGO_HOME:-$HOME/.cargo}/env
    # shellcheck source=/dev/null
    [ ! -f "$env" ] || . "$env"
    if ! have rustup; then
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --component rust-src
        # shellcheck source=/dev/null
        . "$env"
    elif ! rustup component add rust-src; then # standard library sources, rust-analyzer needs them
        warn "could not add rust-src (rust-analyzer needs it), run: rustup component add rust-src"
    fi
    info "$(rustc --version 2>&1 || true)"
}

tree_sitter_version() { tree-sitter --version 2>/dev/null | awk '{print $2}' || true; }

install_tree_sitter() {
    step "tree-sitter CLI >= $TS_CLI_MIN"
    local v
    v=$(tree_sitter_version)
    # nvim-treesitter wants it from a package manager, not npm (whose prebuilt binary can need a newer
    # glibc); Ubuntu 22.04 has none recent enough, so cargo builds it
    if ! version_ge "$v" "$TS_CLI_MIN" || [[ $(readlink -f "$(command -v tree-sitter)") == */node_modules/* ]]; then
        cargo install --locked tree-sitter-cli
        if [ "$(command -v tree-sitter)" != "$CARGO_BIN/tree-sitter" ]; then
            warn "$(command -v tree-sitter) shadows $CARGO_BIN/tree-sitter: remove it (npm uninstall -g tree-sitter-cli) or put $CARGO_BIN first in PATH"
            PATH=$CARGO_BIN:$PATH
        fi
        v=$(tree_sitter_version)
    fi
    info "tree-sitter $v ($(command -v tree-sitter))"
}

install_font() {
    step "FiraCode Nerd Font"
    if fc-list : family 2>/dev/null | grep -i 'FiraCode Nerd Font' >/dev/null; then
        info "already installed"
        return
    fi
    local dir=${XDG_DATA_HOME:-$HOME/.local/share}/fonts/FiraCodeNerdFont
    mkdir -p "$dir"
    curl_get https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.tar.xz | tar -xJ -C "$dir"
    fc-cache -f "$dir"
    info "installed into $dir"
}

install_config() {
    step "Config ($CONFIG_DIR)"
    if [ -e "$CONFIG_DIR" ]; then
        info "already there, left untouched"
    elif [ -L "$CONFIG_DIR" ]; then
        die "$CONFIG_DIR is a broken symlink"
    else
        mkdir -p "$(dirname "$CONFIG_DIR")"
        git clone --depth 1 "$CONFIG_REPO" "$CONFIG_DIR"
    fi
}

# Runs in the headless nvim right after ':Lazy! sync'. The lists come from the lazy specs' opts:
# nvim-treesitter ensure_installed (parsers), mason-lspconfig and mason-nvim-dap ensure_installed
# (servers and adapters, mapped to Mason packages; 'name@version' pins a version), shellcheck for bashls
# and the conform formatters that are not on PATH yet. Missing Mason packages are installed, updates are
# left to :Mason.
write_bootstrap() {
    cat >"$1" <<'LUA'
local TIMEOUT = 60 * 60 * 1000
local problems, warnings = 0, {}

local function say(fmt, ...) -- nvim's own headless messages do not end with a newline
    io.stdout:write("\n", fmt:format(...))
    io.stdout:flush()
end

local function problem(fmt, ...)
    problems = problems + 1
    say("ERROR: " .. fmt, ...)
end

local function warning(fmt, ...) -- repeated in the script's summary
    warnings[#warnings + 1] = fmt:format(...)
    say("WARNING: " .. fmt, ...)
end

local function spec_opts(name)
    local plugin = require("lazy.core.config").plugins[name]
    if not plugin then
        warning("%s is not in the lazy spec", name)
        return {}
    end
    return require("lazy.core.plugin").values(plugin, "opts", false)
end

-- lazy forgets a failed build when nvim exits, so every run checks what the native builds produce
local BUILT = { ["telescope-fzf-native.nvim"] = "build/libfzf.so", LuaSnip = "deps/luasnip-jsregexp.so" }

local function check_plugins() -- lazy keeps failed tasks (clone, build...) until they succeed
    local plugins = require("lazy.core.config").plugins
    for name, file in pairs(BUILT) do
        local plugin = plugins[name]
        local path = plugin and vim.fs.joinpath(plugin.dir, file)
        if plugin and plugin.build and plugin._.installed and not vim.uv.fs_stat(path) then
            say("Building %s", name)
            require("lazy.manage").build({ plugins = { name }, wait = true, show = false })
            if not vim.uv.fs_stat(path) then
                problem("plugin %s: its build did not produce %s", name, file)
            end
        end
    end
    for name, plugin in pairs(plugins) do
        if not plugin._.installed then
            problem("plugin %s is not installed", name)
        end
        for _, task in ipairs(plugin._.tasks or {}) do
            if task:has_errors() then
                problem("plugin %s, %s: %s", name, task.name, task:output(vim.log.levels.ERROR))
            end
        end
    end
end

local function install_parsers()
    local langs = spec_opts("nvim-treesitter").ensure_installed or {}
    if #langs == 0 then
        return warning("nvim-treesitter has no opts.ensure_installed, no parsers were installed")
    end
    local ts = require("nvim-treesitter")
    local function missing() -- queries are copied after the parser, at the end of an install
        local parsers, queries = ts.get_installed("parsers"), ts.get_installed("queries")
        return vim.tbl_filter(function(lang)
            return not (vim.list_contains(parsers, lang) and vim.list_contains(queries, lang))
        end, langs)
    end
    -- install() gives up after 60 s on a parser that the config's own install() is still building: retry
    for round = 1, 5 do
        local todo = missing()
        if #todo == 0 then
            break
        elseif round > 1 then
            vim.wait(5000)
        end
        say("Installing parsers: %s", table.concat(todo, " "))
        -- install() skips a language that has a parser but no queries (an aborted run): force it after round 1
        ts.install(todo, { summary = true, force = round > 1 }):pwait(TIMEOUT)
    end
    -- also finishes the ':TSUpdate' build hook, which ':Lazy! sync' does not wait for
    local ok, updated = ts.update(nil, { summary = true }):pwait(TIMEOUT)
    if not (ok and updated) then
        warning("some parsers could not be updated, run :TSUpdate")
    end
    -- load from the install dir: on a first run the runtime file cache predates it
    local dir = require("nvim-treesitter.config").get_install_dir("parser")
    local incomplete = missing()
    for _, lang in ipairs(langs) do
        local loaded, res, err = pcall(vim.treesitter.language.add, lang, { path = vim.fs.joinpath(dir, lang .. ".so") })
        if not (loaded and res) then
            problem("parser %s: %s", lang, tostring(loaded and err or res))
        elseif vim.list_contains(incomplete, lang) then
            problem("parser %s: its queries are not installed", lang)
        end
    end
end

local function missing_formatters() -- conform formatters whose command is not on PATH (Mason's bin dir included)
    local has_conform, conform = pcall(require, "conform")
    if not has_conform then
        return {}
    end
    return vim.tbl_filter(function(f) -- lua formatters (trim_whitespace...) are available, their command is their name
        return f.error or (not f.available and vim.fn.executable(f.command) == 0)
    end, conform.list_all_formatters())
end

local function install_mason_packages()
    local registry = require("mason-registry")
    local Package = require("mason-core.package")
    local ok, err = registry.refresh() -- synchronous without a callback
    if not ok then
        return problem("Mason registry refresh failed: %s", tostring(err))
    end
    -- let pending refresh callbacks run first: mason-nvim-dap starts its own installs there
    local flushed = false
    vim.schedule(function()
        flushed = true
    end)
    vim.wait(10000, function()
        return flushed
    end)

    local wanted, seen = {}, {}
    local function want(what, name, version)
        if not (name and registry.has_package(name)) then
            return problem("no Mason package for %s", what)
        end
        if not seen[name] then
            seen[name] = true
            wanted[#wanted + 1] = { name = name, version = version ~= "" and version or nil }
        end
    end
    local servers = spec_opts("mason-lspconfig.nvim").ensure_installed or {}
    if #servers == 0 then
        warning("mason-lspconfig.nvim has no opts.ensure_installed, no LSP servers were installed")
    else
        local to_package = require("mason-lspconfig").get_mappings().lspconfig_to_package
        for _, id in ipairs(servers) do
            local server, version = Package.Parse(id)
            want("LSP server " .. server, to_package[server], version)
            if server == "bashls" and vim.fn.executable("shellcheck") == 0 then -- bash-language-server lints with it
                want("shellcheck", "shellcheck")
            end
        end
    end
    local adapters = spec_opts("mason-nvim-dap.nvim").ensure_installed or {}
    if #adapters > 0 then
        local to_package = require("mason-nvim-dap.mappings.source").nvim_dap_to_package
        for _, id in ipairs(adapters) do
            local adapter, version = Package.Parse(id)
            want("DAP adapter " .. adapter, to_package[adapter], version)
        end
    end
    for _, f in ipairs(missing_formatters()) do -- the others (tidy, xmllint) come from apt
        for _, name in ipairs(f.error and {} or { f.name, (f.name:gsub("_", "-")), f.command }) do
            if registry.has_package(name) then
                want("formatter " .. f.name, name)
                break
            end
        end
    end
    say("Mason packages: %s", #wanted == 0 and "none" or table.concat(vim.tbl_map(function(w)
        return w.name .. (w.version and "@" .. w.version or "")
    end, wanted), " "))

    -- done[name] == false while an install runs: it is over (lock released) once the package
    -- emits install:success or install:failed
    local done, failures = {}, {}
    for _, w in ipairs(wanted) do
        local pkg = registry.get_package(w.name)
        pkg:on("install:success", function()
            done[pkg.name] = true
            say("Installed %s %s", pkg.name, pkg:get_installed_version() or "")
        end)
        pkg:on("install:failed", function(result)
            done[pkg.name] = true
            say("Failed to install %s", pkg.name)
            failures[pkg.name] = tostring(result)
            pcall(function() -- installer output, for the error report
                failures[pkg.name] = table.concat(pkg:get_install_handle():get().stdio_sink.buffers.stderr):sub(-3000)
            end)
        end)
    end
    local function pending(w) -- missing, or not at the pinned version
        local pkg = registry.get_package(w.name)
        return not pkg:is_installed() or (w.version ~= nil and pkg:get_installed_version() ~= w.version)
    end
    for _ = 1, 2 do -- the second round retries failures, e.g. a stale lock left by an aborted run
        for _, w in ipairs(wanted) do
            local pkg = registry.get_package(w.name)
            if pkg:is_installing() then -- started by mason-nvim-dap
                done[w.name] = false
            elseif pending(w) then
                say("Installing %s%s", w.name, w.version and "@" .. w.version or "")
                done[w.name] = false
                pkg:install({ version = w.version })
            end
        end
        vim.wait(TIMEOUT, function()
            return not vim.list_contains(vim.tbl_values(done), false)
        end, 200)
    end
    for _, w in ipairs(wanted) do
        if pending(w) then
            problem("Mason package %s: %s", w.name, failures[w.name] or "not installed")
        end
    end
end

local function check_formatters()
    for _, f in ipairs(missing_formatters()) do
        problem("formatter %s: %s", f.name, f.available_msg or "not available")
    end
end

local function download_blink_fuzzy() -- blink.cmp downloads its Rust matcher on first use, do it now
    if not require("lazy.core.config").plugins["blink.cmp"] then
        return
    end
    local done, download_err, impl
    -- the second round retries a download that raced with the one blink.cmp's setup() starts
    for _ = 1, 2 do
        done, download_err, impl = false, nil, nil
        require("blink.cmp.fuzzy.download").ensure_downloaded(function(e, i)
            done, download_err, impl = true, e, i
        end)
        vim.wait(TIMEOUT, function()
            return done
        end, 200)
        if not done or download_err or impl == "rust" then
            break
        end
    end
    if not done or download_err then
        problem("blink.cmp fuzzy matcher: %s", tostring(download_err or "download timed out"))
    elseif impl == "lua" then -- 'prefer_rust*' falls back without an error
        warning("blink.cmp fuzzy matcher: no prebuilt binary, using the slower Lua matcher (see above)")
    end
end

local ok, err = xpcall(function()
    check_plugins()
    download_blink_fuzzy()
    install_parsers()
    install_mason_packages()
    check_formatters()
end, debug.traceback)
if not ok then
    problem("bootstrap failed: %s", err)
end
local file = #warnings > 0 and io.open(vim.env.NVIM_BOOTSTRAP_WARNINGS, "w")
if file then
    file:write(table.concat(warnings, "\n"), "\n")
    file:close()
end
if problems > 0 then
    say("%d problem(s), see the errors above\n", problems)
    vim.cmd("cquit 1")
end
say("Plugins, parsers and Mason packages are installed\n")
vim.cmd("qall!")
LUA
}

# Runs before the config: lazy's task start/end lines and git's progress meters would bury the
# bootstrap's own output (process output is still printed once each command ends, errors included).
# lazy.setup() clones the missing plugins before any '+cmd' runs, so its defaults are changed as soon
# as lazy.core.config is first required.
write_lazy_quiet() {
    cat >"$1" <<'LUA'
package.preload["lazy.core.config"] = function(name)
    package.preload[name] = nil
    for i = 2, #package.loaders do -- the loaders after preload
        local loader = package.loaders[i](name)
        if type(loader) == "function" then
            local config = loader(name)
            config.defaults.headless.task, config.defaults.headless.process = false, false
            return config
        end
    end
    error("lazy.core.config not found")
end
LUA
}

bootstrap() {
    step "Plugins, treesitter parsers and Mason packages"
    write_bootstrap "$tmp/bootstrap.lua"
    write_lazy_quiet "$tmp/lazy_quiet.lua"
    local rc=0 w
    # the last command only runs if the bootstrap itself cannot be loaded
    NVIM_BOOTSTRAP=$tmp/bootstrap.lua NVIM_BOOTSTRAP_WARNINGS=$tmp/warnings "$NVIM" --headless -n -i NONE \
        --cmd "luafile $tmp/lazy_quiet.lua" \
        "+Lazy! sync" '+lua dofile(vim.env.NVIM_BOOTSTRAP)' '+cquit 2' </dev/null || rc=$?
    if [ -s "$tmp/warnings" ]; then
        while IFS= read -r w; do WARNINGS+=("$w"); done <"$tmp/warnings"
    fi
    [ "$rc" -eq 0 ] || die "headless bootstrap failed (see the errors above), re-run the script to retry"
}

java_release() { # major version of the 'java' on PATH
    have java || return 0
    local v
    v=$(java -version 2>&1 | sed -n 's/.* version "\([^"]*\)".*/\1/p' || true)
    v=${v%%$'\n'*}
    v=${v#1.}
    echo "${v%%[!0-9]*}"
}

jdtls_java_release() { # highest Java release required by the bundles of the installed jdtls
    local jar m
    for jar in "$1"/plugins/*.jar; do
        m=$(unzip -p "$jar" META-INF/MANIFEST.MF 2>/dev/null | tr -d '\r') || continue
        case $m in # skip fragments: optional, e.g. jdtls 1.49's javac fragment wants Java 24, jdtls itself 21
            Fragment-Host:* | *$'\n'Fragment-Host:*) continue ;;
        esac
        printf '%s\n' "$m"
    done | sed -e ':a' -e 'N' -e '$!ba' -e 's/\n //g' |
        grep -oE 'JavaSE-[0-9.]+|osgi\.ee=JavaSE\)\(version=[0-9.]+' |
        sed -E 's/.*[-=]//; s/^1\.//; s/\..*//' | sort -n | tail -n 1 || true
}

install_java() {
    step "Java for jdtls"
    local jdtls=$MASON_DIR/packages/jdtls need found codename
    if [ ! -d "$jdtls" ]; then
        info "jdtls is not installed, nothing to do"
        return
    fi
    need=$(jdtls_java_release "$jdtls")
    need=${need:-21}
    found=$(java_release)
    if [ "${found:-0}" -ge "$need" ]; then
        info "java $found ($(command -v java)), jdtls needs $need"
        return
    fi
    info "jdtls needs Java $need, found ${found:-none}: installing Eclipse Temurin $need"
    if ! grep -rqs 'packages\.adoptium\.net' /etc/apt/sources.list /etc/apt/sources.list.d; then
        # shellcheck source=/dev/null
        codename=$(. /etc/os-release && echo "${UBUNTU_CODENAME:-${VERSION_CODENAME:-}}")
        if ! curl_get -I "https://packages.adoptium.net/artifactory/deb/dists/$codename/Release" >/dev/null; then
            warn "Adoptium has no packages for '$codename': install a JDK >= $need yourself"
            return
        fi
        sudo install -d -m 0755 /etc/apt/keyrings
        curl_get https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /etc/apt/keyrings/adoptium.asc >/dev/null
        echo "deb [signed-by=/etc/apt/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb $codename main" |
            sudo tee /etc/apt/sources.list.d/adoptium.list >/dev/null
    fi
    if ! apt_install "temurin-$need-jdk"; then
        warn "could not install temurin-$need-jdk: install a JDK >= $need yourself"
        return
    fi
    hash -r
    found=$(java_release)
    [ "${found:-0}" -ge "$need" ] ||
        warn "'java' on PATH ($(command -v java || echo none)) is ${found:-missing}, jdtls needs $need: put /usr/lib/jvm/temurin-$need-jdk-*/bin first in PATH"
}

summary() {
    step "Done: $("$NVIM" --version | sed -n 1p)"
    [ "$(command -v nvim || true)" = "$NVIM" ] || WARNINGS+=("'nvim' on PATH is $(command -v nvim || echo missing), not $NVIM")
    cat <<'EOF'
    - Open a new terminal (it gets nvm's node and ~/.cargo/bin on PATH) and restart running Neovim instances.
    - Set the terminal font to "FiraCode Nerd Font".
    - LSP servers are installed but not enabled: start one with :lsp enable <name> (jdtls starts on Java files).
EOF
    local w
    for w in "${WARNINGS[@]}"; do
        printf '\033[1;33mWARNING:\033[0m %s\n' "$w"
    done
}

install_packages
install_neovim
install_node
install_rust
install_tree_sitter
install_font
install_config
bootstrap
install_java
summary
