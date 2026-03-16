on run
	try
		do shell script "pgrep -qx claude-history"
		tell application "iTerm2"
			activate
		end tell
		return
	end try

	set iTermWasRunning to true
	try
		do shell script "pgrep -qx iTerm2"
	on error
		set iTermWasRunning to false
	end try

	if iTermWasRunning then
		tell application "iTerm2"
			create window with default profile command "/opt/homebrew/bin/claude-history"
			activate
		end tell
	else
		tell application "iTerm2"
			activate
		end tell
		delay 1
		tell application "iTerm2"
			tell current session of current window
				write text "exec /opt/homebrew/bin/claude-history"
			end tell
		end tell
	end if
end run

on quit
	try
		do shell script "pkill -f '/opt/homebrew/bin/claude-history'"
	end try
	continue quit
end quit

on idle
	try
		do shell script "pgrep -qx claude-history || pgrep -qx claude"
		return 1
	on error
		quit
	end try
end idle
