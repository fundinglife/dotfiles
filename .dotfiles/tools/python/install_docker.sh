#!/bin/bash

pip install --upgrade pip
pip install docker

grep -qxF 'docker' "$HOME/dotfiles/requirements.txt" || echo 'docker' >> "$HOME/dotfiles/requirements.txt"
