# Claude History Dock App

A macOS app that launches `claude-history` in iTerm2 with a custom Dock icon.

Built as an AppleScript app via `osacompile` so it registers properly with macOS and shows its own icon in the Dock while running.

## Setup

```bash
cd claude-history-dock
./setup_claude_history_app.sh
```

Then drag "ClaudeHistory" from `/Applications` to your Dock.

If the icon doesn't show, run `killall Dock`.

## How it works

- Clicking the Dock icon opens iTerm2 with `claude-history`
- If `claude-history` is already running, it just activates iTerm2
- Closing the iTerm2 window auto-quits ClaudeHistory from the Dock
- Quitting ClaudeHistory from the Dock also closes the iTerm2 session

## Customization

Edit `ClaudeHistory.applescript` and re-run `./setup_claude_history_app.sh` to rebuild.

To change the command path, replace `/opt/homebrew/bin/claude-history` in the script.
