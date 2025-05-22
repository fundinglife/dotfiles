#!/bin/bash

pip install --upgrade pip
pip install psycopg2

grep -qxF 'psycopg2' "$HOME/dotfiles/requirements.txt" || echo 'psycopg2' >> "$HOME/dotfiles/requirements.txt"
