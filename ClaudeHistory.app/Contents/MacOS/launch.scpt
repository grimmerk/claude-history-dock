tell application "System Events"
	set isRunning to (name of processes) contains "iTerm2"
end tell

tell application "iTerm2"
	if isRunning then
		create window with default profile command "/opt/homebrew/bin/claude-history"
	else
		activate
		delay 0.5
		tell current session of current window
			write text "exec /opt/homebrew/bin/claude-history"
		end tell
	end if
	activate
end tell
