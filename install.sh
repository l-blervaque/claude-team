#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.local/bin/claude-team"

if [ ! -f "$SCRIPT_DIR/claude-team" ]; then
  echo "Erreur : $SCRIPT_DIR/claude-team introuvable" >&2
  exit 1
fi

if [ -e "$TARGET" ] || [ -L "$TARGET" ]; then
  echo "Mise à jour du symlink existant : $TARGET"
  rm "$TARGET"
fi

mkdir -p "$HOME/.local/bin"
ln -s "$SCRIPT_DIR/claude-team" "$TARGET"
echo "Installé : $TARGET -> $SCRIPT_DIR/claude-team"
