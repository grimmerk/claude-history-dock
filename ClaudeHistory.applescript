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
			set newWindow to (create window with default profile)
			tell current session of newWindow
				write text "/opt/homebrew/bin/claude-history"
			end tell
			activate
		end tell
	else
		tell application "iTerm2"
			activate
		end tell
		delay 1
		tell application "iTerm2"
			tell current session of current window
				write text "/opt/homebrew/bin/claude-history"
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

property idleCount : 0

on idle
	set idleCount to idleCount + 1
	if idleCount < 3 then
		return 1
	end if
	try
		do shell script "pgrep -qx claude-history"
		return 1
	on error
		quit
	end try
end idle
