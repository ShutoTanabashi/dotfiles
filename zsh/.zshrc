#!/usr/bin/env zsh

# zsh setting by sheldon
eval "$(sheldon source)"

# this variable used by zellij etc.
export EDITOR="nvim"

# setting which related environments.
source ~/.zsh_envcfg

# setting for bat
export BAT_THEME="ansi"

# setting for fzf
export FZF_DEFAULT_COMMAND='fd --unrestricted --type file --type directory'
export FZF_DEFAULT_OPTS='--height=~60% --border=horizontal --preview="bat {} --color always"'

# alias
alias ls='eza --icons -a'
alias cat='bat'
alias grep='rg'
alias vi='nvim'
alias llj="zellij"

# prompt
PROMPT='%F{44}%n%f %C $GITSTATUS_PROMPT%F{44}%B %# %b%f'
RPROMPT='%F{66}%3~%f %F{244}%m%f' 

# My functions

# Make zip file for WindowsOS
# Warning: This funciton require fd-find and p7zip.
function zipwin () 
{
	# If the argument is "." or not given, the current directory is used as the target directory.
	if [ -z $1 ] || [ $1 = . ]; then
		local zip_name="$(basename $(pwd)).zip"
		fd --type file --strip-cwd-prefix . -X 7z a -tzip -scsWIN $zip_name {}
	else
		local loc_dir=$(dirname $1)
		local target=$(basename $1)
		local zip_name="$(pwd)/${target}.zip"
		fd --type file --base-directory=$loc_dir . $target -X 7z a -tzip -scsWIN $zip_name {}
	fi
	# Check zipped files
	7z l $zip_name
	return 0	
}
