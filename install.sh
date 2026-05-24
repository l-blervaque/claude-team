#!/usr/bin/env bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET="$HOME/.local/bin/claude-team"

if [ -L "$TARGET" ]; then
  echo "Mise à jour du symlink existant : $TARGET"
  rm "$TARGET"
fi

ln -s "$SCRIPT_DIR/claude-team" "$TARGET"
echo "Installé : $TARGET -> $SCRIPT_DIR/claude-team"
