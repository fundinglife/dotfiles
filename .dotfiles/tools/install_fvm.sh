#!/bin/bash

if ! command -v fvm &> /dev/null; then
    echo "FVM not found. Installing..."
    dart pub global activate fvm
fi

# Install stable version of Flutter using fvm
fvm install stable
