on run
	try
		do shell script "pgrep -qf '/opt/homebrew/bin/claude-history'"
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

on idle
	try
		do shell script "pgrep -qf '/opt/homebrew/bin/claude-history'"
		return 2
	on error
		quit
	end try
end idle
