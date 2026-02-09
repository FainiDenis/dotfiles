#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  exit 0
fi

if [[ -x "$HOME/.dotfiles/macos/configure-smb.sh" ]]; then
  if [[ "${FORCE_SMB_PROMPT:-0}" = "1" ]]; then
    "$HOME/.dotfiles/macos/configure-smb.sh" --force
  else
    "$HOME/.dotfiles/macos/configure-smb.sh"
  fi
fi

AGENT_ID="com.dotfiles.smb-autoconnect"
SOURCE_PLIST="$HOME/.dotfiles/macos/launchagents/${AGENT_ID}.plist"
TARGET_DIR="$HOME/Library/LaunchAgents"
TARGET_PLIST="$TARGET_DIR/${AGENT_ID}.plist"

mkdir -p "$TARGET_DIR"
cp "$SOURCE_PLIST" "$TARGET_PLIST"

launchctl bootout "gui/$(id -u)/$AGENT_ID" >/dev/null 2>&1 || true
launchctl bootstrap "gui/$(id -u)" "$TARGET_PLIST"
launchctl enable "gui/$(id -u)/$AGENT_ID" >/dev/null 2>&1 || true
launchctl kickstart -k "gui/$(id -u)/$AGENT_ID" >/dev/null 2>&1 || true

echo "  Installed LaunchAgent $AGENT_ID"
