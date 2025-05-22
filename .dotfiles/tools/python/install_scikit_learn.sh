#!/bin/bash

pip install --upgrade pip
pip install scikit-learn

grep -qxF 'scikit-learn' "$HOME/dotfiles/requirements.txt" || echo 'scikit-learn' >> "$HOME/dotfiles/requirements.txt"
