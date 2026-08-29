# Load zsh plugins when sheldon is available and configured.
if (( $+commands[sheldon] )) && [[ -f "$HOME/.config/sheldon/plugins.toml" ]]; then
	eval "$(sheldon source)"
fi

# CLI editor settings.
if (( $+commands[nvim] )); then
	export VISUAL="nvim"
	export EDITOR="nvim"
	export SUDO_EDITOR="nvim"
elif (( $+commands[vim] )); then
	export VISUAL="vim"
	export EDITOR="vim"
	export SUDO_EDITOR="vim"
fi

# Environment-dependent settings.
[[ -r "$HOME/.zsh_envcfg" ]] && source "$HOME/.zsh_envcfg"

if (( $+commands[bat] || $+commands[batcat] )); then
	export BAT_THEME="ansi"
fi

# fzf settings.
export FZF_DEFAULT_COMMAND='fd --unrestricted --type file --type directory'
export FZF_DEFAULT_OPTS='--height=~60% --border=horizontal --preview="bat {} --color always"'

# tre wrapper.
if (( $+commands[tre] )); then
	tre() {
		command tre "$@" -e || return
		local aliases_file="/tmp/tre_aliases_${USER}"
		[[ -r "$aliases_file" ]] && source "$aliases_file"
	}
fi

# Aliases for optional tools.
if (( $+commands[eza] )); then
	alias ls='eza --icons=auto'
	alias la='eza --icons=auto -a'
	alias ll='eza --icons=auto -al --git'
fi
if (( $+commands[chafa] )); then
	alias cati='chafa --colors full --size x19'
fi

# Initialize completion after environment-specific fpath entries are added.
autoload -Uz compinit && compinit

# Make a zip file for Windows. Requires fd and 7z.
zipwin() {
	if (( ! $+commands[fd] || ! $+commands[7z] )); then
		print -u2 'zipwin: fd and 7z are required'
		return 127
	fi

	local target_arg="${1:-.}"
	local zip_name
	if [[ "$target_arg" == "." ]]; then
		zip_name="${PWD:t}.zip"
		fd --type file --strip-cwd-prefix . -X 7z a -tzip -scsWIN "$zip_name" {}
	else
		local source_dir="${target_arg:h}"
		local target="${target_arg:t}"
		zip_name="$PWD/${target}.zip"
		fd --type file --base-directory="$source_dir" . "$target" -X 7z a -tzip -scsWIN "$zip_name" {}
	fi

	7z l -- "$zip_name"
}
