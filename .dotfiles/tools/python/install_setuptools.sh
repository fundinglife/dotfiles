#!/bin/bash

pip install --upgrade pip
pip install setuptools

grep -qxF 'setuptools' "$HOME/dotfiles/requirements.txt" || echo 'setuptools' >> "$HOME/dotfiles/requirements.txt"
