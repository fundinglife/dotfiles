#!/bin/bash

pip install --upgrade pip
pip install pinecone-client

grep -qxF 'pinecone-client' "$HOME/dotfiles/requirements.txt" || echo 'pinecone-client' >> "$HOME/dotfiles/requirements.txt"
