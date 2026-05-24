# claude-team — Design Spec

**Date:** 2026-05-24  
**Statut:** Approuvé

## Objectif

Créer une commande `claude-team` qui lance Claude Code avec le mode équipes expérimental activé (`CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`), et qui identifie visuellement la session comme "Claude Team" via le titre de la fenêtre/onglet terminal.

## Structure du projet

```
lubbee/claude-team/
├── claude-team          # script principal (exécutable bash)
├── install.sh           # installe le symlink dans ~/.local/bin/
└── README.md            # usage, install, désinstallation
```

## Script principal (`claude-team`)

```sh
#!/usr/bin/env bash
printf '\033]0;Claude Team\007'
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 exec claude "$@"
```

**Détails d'implémentation :**

- `printf '\033]0;Claude Team\007'` : séquence d'échappement ANSI OSC 0 pour définir le titre de la fenêtre. Compatible avec iTerm2, Terminal.app, Ghostty, Alacritty, et la majorité des émulateurs modernes.
- `exec claude "$@"` : remplace le shell courant par le processus `claude`. Cela garantit que les signaux (SIGINT via Ctrl+C, SIGTERM) sont transmis directement à claude sans passer par un shell intermédiaire, et évite tout processus zombie.
- `"$@"` : tous les arguments passés à `claude-team` sont forwarded sans modification. `claude-team -c`, `claude-team --model opus`, `claude-team --print "..."` — tout fonctionne identiquement à `claude`.

## Installation (`install.sh`)

Crée un symlink `~/.local/bin/claude-team` → `<répertoire projet>/claude-team`.

Le symlink (plutôt qu'une copie) garantit que toute mise à jour du script dans le projet est immédiatement active sans réinstallation.

## Dépendances

Aucune dépendance externe. Prérequis :
- `claude` accessible dans le `PATH` (déjà dans `~/.local/bin/claude`)
- Shell compatible POSIX (bash, zsh)

## Non-objectifs (hors scope)

- Pas de logique d'agents spécifique au mode teams
- Pas de chargement automatique d'un fichier `--settings` ou `--agents`
- Pas de message de démarrage dans le terminal (couvert par le titre de fenêtre)
