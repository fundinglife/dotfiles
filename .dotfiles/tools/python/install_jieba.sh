#!/bin/bash

pip install --upgrade pip
pip install jieba

grep -qxF 'jieba' "$HOME/dotfiles/requirements.txt" || echo 'jieba' >> "$HOME/dotfiles/requirements.txt"
