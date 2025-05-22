#!/bin/bash

pip install --upgrade pip
pip install weaviate-client

grep -qxF 'weaviate-client' "$HOME/dotfiles/requirements.txt" || echo 'weaviate-client' >> "$HOME/dotfiles/requirements.txt"
