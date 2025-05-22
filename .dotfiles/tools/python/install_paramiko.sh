#!/bin/bash

pip install --upgrade pip
pip install paramiko

grep -qxF 'paramiko' "$HOME/dotfiles/requirements.txt" || echo 'paramiko' >> "$HOME/dotfiles/requirements.txt"
