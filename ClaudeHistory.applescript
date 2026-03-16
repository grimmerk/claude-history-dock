property cmdWindowId : missing value
property idleCount : 0

on run
	try
		do shell script "pgrep -qx claude-history"
		focusWindow()
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
			set cmdWindowId to id of newWindow
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
			set cmdWindowId to id of current window
			tell current session of current window
				write text "/opt/homebrew/bin/claude-history"
			end tell
		end tell
	end if
end run

on reopen
	focusWindow()
end reopen

on focusWindow()
	tell application "iTerm2"
		try
			repeat with w in windows
				if id of w is cmdWindowId then
					select w
				end if
			end repeat
		end try
		activate
	end tell
end focusWindow

on quit
	try
		do shell script "pkill -f '/opt/homebrew/bin/claude-history'"
	end try
	continue quit
end quit

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
