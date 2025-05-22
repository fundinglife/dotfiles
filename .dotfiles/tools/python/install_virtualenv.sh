#!/bin/bash

pip install --upgrade pip
pip install virtualenv

grep -qxF 'virtualenv' "$HOME/dotfiles/requirements.txt" || echo 'virtualenv' >> "$HOME/dotfiles/requirements.txt"
