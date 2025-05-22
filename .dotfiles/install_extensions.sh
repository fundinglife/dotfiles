#!/usr/bin/env bash
set -euo pipefail

CONFIG_FILE="./dotfiles.config.json"
EXT_DIR="$HOME/dotfiles/.dotfiles/extensions"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "⚠️  No dotfiles.config.json found. Skipping extensions install."
  exit 0
fi

echo "🔌 Installing VS Code extensions from $CONFIG_FILE..."

jq -c '.extensions[] | select(.install == true)' "$CONFIG_FILE" | while read -r ext_entry; do
  ext_name=$(echo "$ext_entry" | jq -r '.library_name // .name')
  script="$EXT_DIR/install_${ext_name##*.}.sh"
  if [[ -f "$script" ]]; then
    echo "🚀 Installing extension via script: $script"
    bash "$script"
  elif [[ -n "$ext_name" ]]; then
    echo "📦 Installing extension: $ext_name"
    code --install-extension "$ext_name"
    mkdir -p "$HOME/dotfiles/.vscode"
    touch "$HOME/dotfiles/.vscode/extensions.list"
    grep -qxF "$ext_name" "$HOME/dotfiles/.vscode/extensions.list" || echo "$ext_name" >> "$HOME/dotfiles/.vscode/extensions.list"
  fi
done
