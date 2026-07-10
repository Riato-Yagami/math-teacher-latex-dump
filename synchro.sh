#!/usr/bin/env bash

set -euo pipefail

PRIVATE_SUBMODULE_PATH="cours-de-math"
PUBLIC_REPO_PATH="cours-de-math-public"
PUBLIC_REPO_URL="https://github.com/Riato-Yagami/cours-de-math-public.git"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRIVATE_DIR="$SCRIPT_DIR/$PRIVATE_SUBMODULE_PATH"
PUBLIC_DIR="$SCRIPT_DIR/$PUBLIC_REPO_PATH"

echo "=== Synchronisation cours-de-math -> cours-de-math-public ==="
echo ""

if [ ! -d "$PRIVATE_DIR" ]; then
    echo "Dossier prive introuvable : $PRIVATE_DIR" >&2
    exit 1
fi

if [ ! -d "$PUBLIC_DIR" ]; then
    git clone "$PUBLIC_REPO_URL" "$PUBLIC_DIR"
fi

if [ ! -d "$PUBLIC_DIR/.git" ]; then
    echo "Le dossier public n'est pas un depot git : $PUBLIC_DIR" >&2
    exit 1
fi

echo "Source privee : $PRIVATE_SUBMODULE_PATH"
echo "Cible publique : $PUBLIC_REPO_PATH"
echo "Le dossier prive n'est jamais modifie par ce script."
echo ""

RSYNC_FILTERS=(
    # Never copy private git metadata and never delete public git metadata.
    --filter='P .git'
    --filter='P .git/***'
    --filter='- .git'
    --filter='- .git/***'

    # Evaluation-related content stays private.
    --exclude='*[Ee][Vv][Aa][Ll]*'
    --exclude='*[Éé][Vv][Aa][Ll]*'
    --exclude='*[Ii]nterro*'
    --exclude='*[Cc]ontrole*'
    --exclude='*[Cc]ontrôle*'
    --exclude='*[Tt]est*'

    # In documents/resources, only the enseignement subtree is public.
    --include='/documents/'
    --include='/documents/enseignement/***'
    --exclude='/documents/***'
    --include='/resources/'
    --include='/resources/enseignement/***'
    --exclude='/resources/***'
    --include='/ressources/'
    --include='/ressources/enseignement/***'
    --exclude='/ressources/***'
)

rsync -av --delete --delete-excluded "${RSYNC_FILTERS[@]}" "$PRIVATE_DIR/" "$PUBLIC_DIR/"

(
    cd "$PUBLIC_DIR"
    git add .
    if git commit -m "Update mirrored content from private submodule"; then
        git push origin main
    else
        echo "Rien a commit"
    fi
)

echo ""
echo "=== Synchronisation terminee ==="
