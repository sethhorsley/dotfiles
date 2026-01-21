#!/usr/bin/env bash

set -eufo pipefail

echo "==> ⚙️  Configuring macOS System Settings"

# Remap Caps Lock to Control for all keyboards
echo "==> 🔤 Remapping Caps Lock to Control"

# Get all keyboard IDs
keyboard_ids=$(ioreg -n IOHIDKeyboard -r | grep -E 'VendorID"|ProductID' | awk '{ print $4 }' | paste -s -d'-\n' -)

# Alternative method using defaults for built-in keyboard
# The value 0 = Caps Lock, mapped to modifier 2 = Control
defaults -currentHost write -g com.apple.keyboard.modifiermapping.1452-641-0 -array-add '
<dict>
  <key>HIDKeyboardModifierMappingDst</key>
  <integer>2</integer>
  <key>HIDKeyboardModifierMappingSrc</key>
  <integer>0</integer>
</dict>
'

echo "==> 🖱️  Setting mouse tracking speed to very fast"
# Mouse tracking speed: range from 0 to 3 (3 is very fast)
defaults write -g com.apple.mouse.scaling -float 3.0

echo "==> 🖱️  Setting trackpad tracking speed to very fast"
# Trackpad tracking speed: range from 0 to 3 (3 is very fast)
defaults write -g com.apple.trackpad.scaling -float 3.0

echo "==> 🔄 Restarting affected services"
# Kill affected applications to apply changes
killall cfprefsd 2>/dev/null || true

echo ""
echo "✅ System settings configured successfully!"
echo ""
echo "⚠️  NOTE: You may need to log out and log back in for the Caps Lock remapping to take full effect."
echo "    Alternatively, you can manually set it in System Settings > Keyboard > Keyboard Shortcuts > Modifier Keys"
echo ""
