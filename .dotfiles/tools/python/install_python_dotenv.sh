#!/bin/bash

pip install --upgrade pip
pip install python-dotenv

grep -qxF 'python-dotenv' "$HOME/dotfiles/requirements.txt" || echo 'python-dotenv' >> "$HOME/dotfiles/requirements.txt"
