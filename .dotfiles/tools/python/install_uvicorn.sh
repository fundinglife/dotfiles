#!/bin/bash

# Install Uvicorn (ASGI server)
pip install --upgrade pip
pip install uvicorn

grep -qxF 'uvicorn' "$HOME/dotfiles/requirements.txt" || echo 'uvicorn' >> "$HOME/dotfiles/requirements.txt"
