#!/bin/bash

# Install FastAPI and Uvicorn (ASGI server)
pip install --upgrade pip
pip install fastapi
grep -qxF 'fastapi' "$HOME/dotfiles/requirements.txt" || echo 'fastapi' >> "$HOME/dotfiles/requirements.txt"
