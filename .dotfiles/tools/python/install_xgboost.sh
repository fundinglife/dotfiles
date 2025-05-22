#!/bin/bash

pip install --upgrade pip
pip install xgboost

grep -qxF 'xgboost' "$HOME/dotfiles/requirements.txt" || echo 'xgboost' >> "$HOME/dotfiles/requirements.txt"
