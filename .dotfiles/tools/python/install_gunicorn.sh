#!/bin/bash

pip install --upgrade pip
pip install gunicorn

grep -qxF 'gunicorn' "$HOME/dotfiles/requirements.txt" || echo 'gunicorn' >> "$HOME/dotfiles/requirements.txt"
