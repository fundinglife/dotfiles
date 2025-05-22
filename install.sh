#!/usr/bin/env bash
# install.sh – auto-run on Codespace startup

# Load environment variables from .env if it exists
if [ -f ".env" ]; then
  set -o allexport
  source .env
  set +o allexport
fi

DOTFILES_DIR="/workspaces/dotfiles/.dotfiles"
WORKSPACE_DIR="/workspaces/dotfiles"
PARENT_DIR="/workspaces/dotfiles"
JSON="/dotfiles.config.json"
VSCODE="/.vscode"
VSCODE_SETTINGS="/.vscode-settings.json"
TOOLS="/install_tools.sh"
EXTENSIONS="/install_extensions.sh"
SETTINGS="/install_settings.sh"

# Set correct config file path for scripts
export CONFIG_FILE="$DOTFILES_DIR$JSON"

# Copy dotfiles.config.json from parent if it exists, else from current directory
if [ -f "$PARENT_DIR$JSON" ]; then
  cp "$PARENT_DIR$JSON" "$DOTFILES_DIR$JSON"
elif [ -f "$WORKSPACE_DIR$JSON" ]; then
  cp "$WORKSPACE_DIR$JSON" "$DOTFILES_DIR$JSON"
else
  echo "❌ dotfiles.config.json not found in parent or current directory."
  exit 1
fi

# Install tools
if [ -f "$DOTFILES_DIR$TOOLS" ]; then
  bash "$DOTFILES_DIR$TOOLS"
else
  echo "❌ install_tools.sh not found in .dotfiles."
fi

# Install extensions
if [ -f "$DOTFILES_DIR$EXTENSIONS" ]; then
  bash "$DOTFILES_DIR$EXTENSIONS"
else
  echo "❌ install_extensions.sh not found in .dotfiles."
fi

# Install settings
if [ -f "$DOTFILES_DIR$SETTINGS" ]; then
  bash "$DOTFILES_DIR$SETTINGS"
else
  echo "❌ install_settings.sh not found in .dotfiles."
fi

# Copy .vscode file to parent folder if it exists and is accessible
if [ -d "$WORKSPACE_DIR$VSCODE" ]; then
  mkdir -p "$PARENT_DIR$VSCODE"
  cp -r "$WORKSPACE_DIR$VSCODE/"* "$PARENT_DIR$VSCODE/"
fi