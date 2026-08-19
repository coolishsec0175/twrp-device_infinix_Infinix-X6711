#!/system/bin/sh
#
# Validate the saved OrangeFox theme/navbar files before a theme reload.
#
# Unlike the previous destructive version, this does NOT wipe a working theme
# on every boot, so the dark-mode / custom theme persists across reboots. It
# only discards individual files that are missing or clearly broken (which
# could otherwise stall the GUI on boot when /data auto-decrypts).
#
# The engine-side validation (gui_validate_theme_files, see
# ofox_startup_reload_fix.patch) already handles this too; this hook is a
# device-side safety net.

FOX_BASE=/sdcard/Fox
THEME="$FOX_BASE/.theme"
NAVBAR="$FOX_BASE/.navbar"

# /data not mounted/decrypted yet - nothing we can do, exit quietly
[ -d "$FOX_BASE" ] || exit 0
[ -d "$THEME" ] || [ -d "$NAVBAR" ] || exit 0

# A valid OrangeFox theme XML must have a <recovery> or <install> root element.
# rapidxml's non-throwing parser yields an empty/incomplete doc for bad XML,
# so a missing/empty root here means the file is unusable.
theme_file_valid() {
    [ -s "$1" ] || return 1
    grep -q '<recovery' "$1" || grep -q '<install' "$1"
}

for f in \
    "$THEME/font.xml" \
    "$THEME/style.xml" \
    "$THEME/accent.xml" \
    "$THEME/action.xml" \
    "$NAVBAR/navbar.xml"; do
    [ -f "$f" ] || continue
    if ! theme_file_valid "$f"; then
        echo "OrangeFox: discarding stale theme file '$f'"
        rm -f "$f"
    fi
done

# If the dirs are now empty, drop them so the engine falls back to stock theme
[ -z "$(ls -A "$THEME" 2>/dev/null)" ] && rm -rf "$THEME"
[ -z "$(ls -A "$NAVBAR" 2>/dev/null)" ] && rm -rf "$NAVBAR"

exit 0