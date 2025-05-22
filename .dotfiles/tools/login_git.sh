#!/bin/bash

echo "Logging into Git (set up credentials)..."
git config --global credential.helper 'cache --timeout=3600'
echo "You may need to run 'git credential approve' or use 'git credential' commands as needed."
