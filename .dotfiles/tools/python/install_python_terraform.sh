#!/bin/bash

pip install --upgrade pip
pip install python-terraform

grep -qxF 'python-terraform' "$HOME/dotfiles/requirements.txt" || echo 'python-terraform' >> "$HOME/dotfiles/requirements.txt"
