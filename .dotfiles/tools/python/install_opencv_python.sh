#!/bin/bash

pip install --upgrade pip
pip install opencv-python

grep -qxF 'opencv-python' "$HOME/dotfiles/requirements.txt" || echo 'opencv-python' >> "$HOME/dotfiles/requirements.txt"
