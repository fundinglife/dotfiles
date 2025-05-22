#!/bin/bash

pip install --upgrade pip
pip install torchvision

grep -qxF 'torchvision' "$HOME/dotfiles/requirements.txt" || echo 'torchvision' >> "$HOME/dotfiles/requirements.txt"
