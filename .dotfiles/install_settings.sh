#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE="./dotfiles.config.json"
SETTINGS_FILE="/workspaces/dotfiles/.vscode-settings.json"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "⚠️  No dotfiles.config.json found. Skipping settings export."
  exit 0
fi

echo "⚙️  Exporting VS Code settings from $CONFIG_FILE..."

mkdir -p "$(dirname "$SETTINGS_FILE")"
jq '(.settings | map(select(.install == true) | { (.name): .setting_value }) | add)' "$CONFIG_FILE" > "$SETTINGS_FILE"
echo "✅ VS Code settings written to $SETTINGS_FILE"
