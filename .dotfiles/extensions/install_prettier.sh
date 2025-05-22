#!/bin/bash

# Install Prettier VS Code extension
code --install-extension esbenp.prettier-vscode

# Add to .vscode file in root if not already present
grep -qxF 'esbenp.prettier-vscode' "$HOME/dotfiles/.vscode" || echo 'esbenp.prettier-vscode' >> "$HOME/dotfiles/.vscode"
