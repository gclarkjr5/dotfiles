# Nushell Environment Config File
#
# version = "0.92.2"

def create_left_prompt [] {
    starship prompt --cmd-duration $env.CMD_DURATION_MS $'--status=($env.LAST_EXIT_CODE)'
}
# def create_left_prompt [] {
#     let dir = match (do --ignore-shell-errors { $env.PWD | path relative-to $nu.home-path }) {
#         null => $env.PWD
#         '' => '~'
#         $relative_pwd => ([~ $relative_pwd] | path join)
#     }

#     let path_color = (if (is-admin) { ansi red_bold } else { ansi green_bold })
#     let separator_color = (if (is-admin) { ansi light_red_bold } else { ansi light_green_bold })
#     let path_segment = $"($path_color)($dir)"

#     $path_segment | str replace --all (char path_sep) $"($separator_color)(char path_sep)($path_color)"
# }

def create_right_prompt [] {
    # create a right prompt in magenta with green separators and am/pm underlined
    let time_segment = ([
        (ansi reset)
        (ansi magenta)
        (date now | format date '%x %X') # try to respect user's locale
    ] | str join | str replace --regex --all "([/:])" $"(ansi green)${1}(ansi magenta)" |
        str replace --regex --all "([AP]M)" $"(ansi magenta_underline)${1}")

    let last_exit_code = if ($env.LAST_EXIT_CODE != 0) {([
        (ansi rb)
        ($env.LAST_EXIT_CODE)
    ] | str join)
    } else { "" }

    ([$last_exit_code, (char space), $time_segment] | str join)
}

# Use nushell functions to define your right and left prompt
$env.PROMPT_COMMAND = {|| create_left_prompt }
# FIXME: This default is not implemented in rust code as of 2023-09-08.
$env.PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
$env.PROMPT_INDICATOR = {|| "> " }
$env.PROMPT_INDICATOR_VI_INSERT = {|| ": " }
$env.PROMPT_INDICATOR_VI_NORMAL = {|| "> " }
$env.PROMPT_MULTILINE_INDICATOR = {|| "::: " }

# If you want previously entered commands to have a different prompt from the usual one,
# you can uncomment one or more of the following lines.
# This can be useful if you have a 2-line prompt and it's taking up a lot of space
# because every command entered takes up 2 lines instead of 1. You can then uncomment
# the line below so that previously entered commands show with a single `🚀`.
# $env.TRANSIENT_PROMPT_COMMAND = {|| "🚀 " }
# $env.TRANSIENT_PROMPT_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_INSERT = {|| "" }
# $env.TRANSIENT_PROMPT_INDICATOR_VI_NORMAL = {|| "" }
# $env.TRANSIENT_PROMPT_MULTILINE_INDICATOR = {|| "" }
# $env.TRANSIENT_PROMPT_COMMAND_RIGHT = {|| "" }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
$env.ENV_CONVERSIONS = {
    "PATH": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
    "Path": {
        from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
        to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
    }
}

# Directories to search for scripts when calling source or use
# The default for this is $nu.default-config-dir/scripts
$env.NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts') # add <nushell-config-dir>/scripts
]

# Directories to search for plugin binaries when calling register
# The default for this is $nu.default-config-dir/plugins
$env.NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins') # add <nushell-config-dir>/plugins
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# $env.PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
# An alternate way to add entries to $env.PATH is to use the custom command `path add`
# which is built into the nushell stdlib:
# use std "path add"
# $env.PATH = ($env.PATH | split row (char esep))
# path add /some/path
# path add ($env.CARGO_HOME | path join "bin")
# path add ($env.HOME | path join ".local" "bin")
# $env.PATH = ($env.PATH | uniq)

# To load from a custom file you can use:
# source ($nu.default-config-dir | path join 'custom.nu')

def --env y [...args] {
	let tmp = (mktemp -t "yazi-cwd.XXXXXX")
	yazi ...$args --cwd-file $tmp
	let cwd = (open $tmp)
	if $cwd != "" and $cwd != $env.PWD {
		cd $cwd
	}
	rm -fp $tmp
}

# custom environment variables
$env.PATH = ($env.PATH | split row (char esep) | append '/sbin')
$env.PATH = ($env.PATH | split row (char esep) | append '/usr/sbin')
$env.PATH = ($env.PATH | split row (char esep) | append '~/.nix-profile/bin')
$env.PATH = ($env.PATH | split row (char esep) | append '/nix/var/nix/profiles/default/bin')
$env.PATH = ($env.PATH | split row (char esep) | append '/opt/homebrew/bin')
$env.PATH = ($env.PATH | split row (char esep) | append '/usr/local/bin')
#$env.PATH = ($env.PATH | split row (char esep) | append '/opt/homebrew/opt/llvm/bin')
$env.PATH = ($env.PATH | split row (char esep) | append '~/.cargo/bin')
$env.PATH = ($env.PATH | split row (char esep) | append '~/.local/bin')
$env.PATH = ($env.PATH | split row (char esep) | append '~/.pyenv/shims')
#$env.PATH = ($env.PATH | split row (char esep) | append '/Applications/Visual Studio Code.app/Contents/Resources/app/bin')
$env.PATH = ($env.PATH | split row (char esep) | append '~/google-cloud-sdk/bin')
#$env.PATH = ($env.PATH | split row (char esep) | append '/Applications/Docker.app/Contents/Resources/bin')
#$env.PATH = ($env.PATH | split row (char esep) | append '~/.fluvio/bin')
$env.PATH = ($env.PATH | split row (char esep) | append '~/.azcopy/azcopy_darwin_arm64_10.25.1')
$env.PATH = ($env.PATH | split row (char esep) | append '~/.npm-global/bin')
$env.PYENV_ROOT = '~/.pyenv'
$env.PIP_REQUIRE_VIRTUALENV = 'true'
$env.EDITOR = "hx"
$env.DEEPL_AUTH_KEY = "97491283-fecb-4552-b4ed-43fcdf01eeec:fx"
$env.STARSHIP_SHELL = "nu"
$env.XDG_CONFIG_HOME = ('~/.config' | path expand )
$env.XDG_DATA_HOME = ('~/.config' | path expand )

# added for git key, specifically for gitui
#ssh-add ~/.ssh/id_ecdsa
#ssh-add ~/.ssh/buy-bay-bitbucket
ssh-add ~/.ssh/fedex_ssh


mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

# zoxide specifics -- commented out as they havent handle nushell deprecation of def-env -> dev --env
zoxide init nushell | save -f ~/.zoxide.nu

# atuin stuff
mkdir ~/.local/share/atuin/
atuin init nu | save -f ~/.local/share/atuin/init.nu
