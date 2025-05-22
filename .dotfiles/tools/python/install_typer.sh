#!/bin/bash

pip install --upgrade pip
pip install typer

grep -qxF 'typer' "$HOME/dotfiles/requirements.txt" || echo 'typer' >> "$HOME/dotfiles/requirements.txt"
