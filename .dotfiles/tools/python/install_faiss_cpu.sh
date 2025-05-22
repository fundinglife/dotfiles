#!/bin/bash

pip install --upgrade pip
pip install faiss-cpu

grep -qxF 'faiss-cpu' "$HOME/dotfiles/requirements.txt" || echo 'faiss-cpu' >> "$HOME/dotfiles/requirements.txt"
