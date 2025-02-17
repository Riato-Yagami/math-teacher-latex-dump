#!/bin/bash

# Define paths
PRIVATE_SUBMODULE_PATH="cours-de-math"
PUBLIC_REPO_PATH="cours-de-math-public"

# Ensure the submodules are initialized and updated
git submodule update --init --recursive

# Clone the public repository if it doesn't exist
if [ ! -d "$PUBLIC_REPO_PATH" ]; then
    git clone https://github.com/Riato-Yagami/cours-de-math-public.git $PUBLIC_REPO_PATH
fi

# Ensure we are on the main branch in the public repository
cd $PUBLIC_REPO_PATH
git checkout main

# Ensure we are on the main branch in the private submodule
cd ../$PRIVATE_SUBMODULE_PATH
git checkout main

# Copy relevant files from the private submodule to the public repository
cd ../$PUBLIC_REPO_PATH
rsync -av --exclude='test/' --exclude='test.tex' --exclude='interrogation.tex' --exclude='interro.tex' --exclude='*-evaluations/' ../$PRIVATE_SUBMODULE_PATH/ .

# Debugging: List files in the public repository directory
echo "Files in the public repository directory:"
ls -la

# Commit and push changes to the public repository
git add .
if git commit -m "Update mirrored content from private submodule"; then
    git push origin main
else
    echo "Nothing to commit"
fi