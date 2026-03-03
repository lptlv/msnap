#!/bin/sh
set -e

REPO="https://github.com/atheeq-rhxn/msnap.git"
TMP="$(mktemp -d)"
BIN_DIR="$HOME/.local/bin"
CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/msnap"

echo "Cloning msnap…"
git clone --depth=1 "$REPO" "$TMP"

echo "Installing binaries to $BIN_DIR…"
mkdir -p "$BIN_DIR"
chmod +x "$TMP/cli/msnap"
cp "$TMP/cli/msnap" "$BIN_DIR/msnap"

echo "Installing configs to $CONFIG_DIR…"
mkdir -p "$CONFIG_DIR"
cp -n "$TMP/cli/msnap.conf" "$CONFIG_DIR/"

echo "Installing gui to $CONFIG_DIR/gui"
mkdir -p "$CONFIG_DIR/gui"
cp "$TMP/gui/shell.qml" "$CONFIG_DIR/gui/"
cp "$TMP/gui/RegionSelector.qml" "$CONFIG_DIR/gui/"
cp "$TMP/gui/Icon.qml" "$CONFIG_DIR/gui/"
cp "$TMP/gui/Config.qml" "$CONFIG_DIR/gui/"
cp -n "$TMP/gui/gui.conf" "$CONFIG_DIR/"

mkdir -p "$CONFIG_DIR/gui/icons"
cp "$TMP/gui/icons/"*.svg "$CONFIG_DIR/gui/icons/"

echo "Cleaning up…"
rm -rf "$TMP"
echo

echo "Done!"
echo "✔ msnap (unified CLI) → $BIN_DIR"
echo "✔ msnap.conf → $CONFIG_DIR"
echo "✔ gui → $CONFIG_DIR/gui"

echo
echo "Launch gui with:"
echo "    qs -p $CONFIG_DIR/gui"
echo
echo "Make sure $BIN_DIR is in your PATH:"
echo "    export PATH=\"$BIN_DIR:\$PATH\""
echo
echo "Usage:"
echo "    msnap shot [OPTIONS]      # Take a screenshot"
echo "    msnap cast [OPTIONS]      # Record screen"
echo
echo "For detailed help:"
echo "    msnap --help"
echo "    msnap shot --help"
echo "    msnap cast --help"
