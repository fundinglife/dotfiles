#!/bin/bash

pip install --upgrade pip
pip install faiss-gpu

grep -qxF 'faiss-gpu' "$HOME/dotfiles/requirements.txt" || echo 'faiss-gpu' >> "$HOME/dotfiles/requirements.txt"
