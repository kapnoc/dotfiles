if status is-interactive
	# Commands to run in interactive sessions can go here

	function fish_user_key_bindings
		# Execute this once per mode that emacs bindings should be used in
		fish_default_key_bindings -M insert

		# Then execute the vi-bindings so they take precedence when there's a conflict.
		# Without --no-erase fish_vi_key_bindings will default to
		# resetting all bindings.
		# The argument specifies the initial mode (insert, "default" or visual).
		fish_vi_key_bindings --no-erase insert
	end

	function fish_greeting
		fastfetch
	end


	# export NVM_DIR="$HOME/.nvm"
	# [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
	# [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

	export PATH="$PATH:/Applications/Postgres.app/Contents/Versions/latest/bin"

	export PATH="$PATH:/Users/kapnoc/pkg/flutter/bin"

	export EDITOR='nvim'
	export PAGER='less -R'

	# common use aliases
	alias ..='cd ..'
	alias cl='clear'
	alias ll='ls -l'
	alias la='ls -la'
	alias ne='emacs -nw'
	alias vv='nvim'
	alias vimr='/Applications/VimR.app/Contents/Resources/vimr'
	alias aled="startx -- vt1"

	# git aliases
	alias ga='git add'
	alias gc='git checkout'
	alias gco='git commit'
	alias gd='git diff'
	alias gl='git log'
	alias gpl='git pull'
	alias gps='git push'
	alias gs='git status'

	# less used aliases
	# wttr()
	# {
	# curl -H "Accept-Language: ${LANG%_*}" wttr.in/"${1:-Helsinki}"
	# }

end
