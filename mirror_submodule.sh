#!/bin/bash

# Define paths
PRIVATE_SUBMODULE_PATH="cours-de-math"
PUBLIC_REPO_PATH="../cours-de-math-public"

# Clone the public repository if it doesn't exist
if [ ! -d "$PUBLIC_REPO_PATH" ]; then
    git clone https://github.com/YourUsername/cours-de-math-public.git $PUBLIC_REPO_PATH
fi

# Copy relevant files from the private submodule to the public repository
rsync -av --exclude='test/' --exclude='test.tex' --exclude='interrogation.tex' --exclude='interro.tex' --exclude='*-evaluations/' $PRIVATE_SUBMODULE_PATH/ $PUBLIC_REPO_PATH/

# Commit and push changes to the public repository
cd $PUBLIC_REPO_PATH
git add .
git commit -m "Update mirrored content from private submodule"
git push origin main