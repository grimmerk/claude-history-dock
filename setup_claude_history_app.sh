#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_NAME="ClaudeHistory"
APP_DIR="/Applications/$APP_NAME.app"

echo "Setting up Claude History app (iTerm2 version)..."

# Remove old version if exists
rm -rf "$APP_DIR"

# Build AppleScript app with osacompile (-s for stay-open / on idle support)
echo "Building app with osacompile..."
osacompile -o "$APP_DIR" -s "$SCRIPT_DIR/$APP_NAME.applescript"

# Generate .icns from the PNG and replace the default applet icon
if command -v sips &>/dev/null && command -v iconutil &>/dev/null; then
    echo "Generating app icon..."
    ICONSET_DIR=$(mktemp -d)/AppIcon.iconset
    mkdir -p "$ICONSET_DIR"

    SRC_PNG="$SCRIPT_DIR/icon_1024.png"

    sips -z 16 16     "$SRC_PNG" --out "$ICONSET_DIR/icon_16x16.png"      2>/dev/null
    sips -z 32 32     "$SRC_PNG" --out "$ICONSET_DIR/icon_16x16@2x.png"   2>/dev/null
    sips -z 32 32     "$SRC_PNG" --out "$ICONSET_DIR/icon_32x32.png"      2>/dev/null
    sips -z 64 64     "$SRC_PNG" --out "$ICONSET_DIR/icon_32x32@2x.png"   2>/dev/null
    sips -z 128 128   "$SRC_PNG" --out "$ICONSET_DIR/icon_128x128.png"    2>/dev/null
    sips -z 256 256   "$SRC_PNG" --out "$ICONSET_DIR/icon_128x128@2x.png" 2>/dev/null
    sips -z 256 256   "$SRC_PNG" --out "$ICONSET_DIR/icon_256x256.png"    2>/dev/null
    sips -z 512 512   "$SRC_PNG" --out "$ICONSET_DIR/icon_256x256@2x.png" 2>/dev/null
    sips -z 512 512   "$SRC_PNG" --out "$ICONSET_DIR/icon_512x512.png"    2>/dev/null
    sips -z 1024 1024 "$SRC_PNG" --out "$ICONSET_DIR/icon_512x512@2x.png" 2>/dev/null

    # osacompile uses "applet.icns" as the icon filename
    iconutil -c icns "$ICONSET_DIR" -o "$APP_DIR/Contents/Resources/applet.icns"
    echo "Icon generated"
else
    echo "Warning: sips/iconutil not found, skipping icon generation"
fi

# Re-register with Launch Services and clear icon cache
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f "$APP_DIR"
/usr/bin/touch "$APP_DIR"

echo ""
echo "Done! App installed at: $APP_DIR"
echo ""
echo "Next steps:"
echo "  1. Open Finder -> /Applications"
echo "  2. Drag 'ClaudeHistory' to your Dock"
echo ""
echo "If the icon doesn't show, try:"
echo "  killall Dock"
