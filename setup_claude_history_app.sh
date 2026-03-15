#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
APP_NAME="ClaudeHistory"
APP_DIR="$HOME/Applications/$APP_NAME.app"

echo "🔧 Setting up Claude History app..."

# Remove old version if exists
rm -rf "$APP_DIR"

# Copy the app bundle
cp -R "$SCRIPT_DIR/$APP_NAME.app" "$HOME/Applications/"

# Generate .icns from the PNG if sips and iconutil are available
if command -v sips &>/dev/null && command -v iconutil &>/dev/null; then
    echo "🎨 Generating app icon..."
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
    
    iconutil -c icns "$ICONSET_DIR" -o "$APP_DIR/Contents/Resources/AppIcon.icns"
    echo "✅ Icon generated"
else
    echo "⚠️  sips/iconutil not found, skipping icon generation"
fi

# Clear icon cache so Dock picks up the new icon
/usr/bin/touch "$APP_DIR"

echo ""
echo "✅ Done! App installed at: $APP_DIR"
echo ""
echo "Next steps:"
echo "  1. Open Finder → ~/Applications"
echo "  2. Drag 'Claude History' to your Dock"
echo ""
echo "💡 If the icon doesn't show, try:"
echo "   killall Dock"
echo ""
echo "💡 If 'claude-history' is not in your PATH, edit:"
echo "   $APP_DIR/Contents/MacOS/ClaudeHistory"
echo "   and replace 'claude-history' with the full path, e.g.:"
echo "   /Users/$(whoami)/.local/bin/claude-history"
