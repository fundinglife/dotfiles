#!/bin/bash

pip install --upgrade pip
pip install langchain

grep -qxF 'langchain' "$HOME/dotfiles/requirements.txt" || echo 'langchain' >> "$HOME/dotfiles/requirements.txt"
