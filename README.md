# Claude History Dock App

A macOS app that launches `claude-history` in Ghostty terminal.

## Quick Setup

```bash
cd claude-history-dock
chmod +x setup_claude_history_app.sh
./setup_claude_history_app.sh
```

Then drag "Claude History" from `~/Applications` to your Dock.

## Manual Setup

1. Copy `ClaudeHistory.app` to `~/Applications/`
2. Drag it to the Dock
3. Click to launch — it opens Ghostty and runs `claude-history`

## Customization

### Change the command
Edit `ClaudeHistory.app/Contents/MacOS/ClaudeHistory`

### Change the terminal
Replace `open -na Ghostty` with your preferred terminal.

### Fix PATH issues
If `claude-history` isn't found, use the full path in the script:
```bash
open -na Ghostty --args --initial-command="/full/path/to/claude-history"
```

## Troubleshooting

- **Icon not showing?** Run `killall Dock`
- **"Allow Ghostty to Execute" dialog?** Using `--initial-command` instead of `-e` should avoid this. If it still appears, use the AppleScript fallback below:

```bash
#!/bin/bash
osascript <<APPLESCRIPT
tell application "Ghostty" to activate
delay 0.5
tell application "System Events"
    tell process "Ghostty"
        keystroke "claude-history"
        keystroke return
    end tell
end tell
APPLESCRIPT
```
