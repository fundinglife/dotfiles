#!/usr/bin/env bash
set -euo pipefail

TOOLS_DIR="/workspaces/dotfiles/.dotfiles/tools"
CONFIG_FILE="./dotfiles.config.json"

if [[ ! -f "$CONFIG_FILE" ]]; then
  echo "⚠️  No dotfiles.config.json found. Skipping install."
  exit 0
fi

echo "📦 Installing tools from $CONFIG_FILE..."

# Loop through each tool object
jq -c '.tools[] | select(.install == true)' "$CONFIG_FILE" | while read -r tool_entry; do
  tool_cli=$(echo "$tool_entry" | jq -r '.cli_name')
  script="${TOOLS_DIR}/install_${tool_cli}.sh"

  # Install the tool if installer exists
  if [[ -f "$script" ]]; then
    echo "🚀 Installing $tool_cli..."
    bash "$script"
  else
    echo "❌ No installer found for $tool_cli"
  fi

  # If tool has packages, install each package marked install: true
  if echo "$tool_entry" | jq -e '.packages' > /dev/null; then
    for pkg in $(echo "$tool_entry" | jq -c '.packages[] | select(.install == true)'); do
      pkg_name=$(echo "$pkg" | jq -r '.name')
      pkg_script="${TOOLS_DIR}/${tool_cli}/install_${pkg_name}.sh"
      if [[ -f "$pkg_script" ]]; then
        echo "🔧 Installing $tool_cli/$pkg_name..."
        bash "$pkg_script"
      else
        echo "❌ No installer for $tool_cli/$pkg_name"
      fi
    done
  fi

done