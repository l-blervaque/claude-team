# claude-team

Lance Claude Code avec le mode équipes expérimental activé.

## Ce que ça fait

- Active `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`
- Affiche "Claude Team" dans le titre de la fenêtre/onglet terminal
- Passe tous les arguments à `claude` sans modification

## Installation

```bash
./install.sh
```

Crée un symlink `~/.local/bin/claude-team` → ce répertoire.  
`~/.local/bin` doit être dans ton `PATH` (c'est déjà le cas si `claude` fonctionne).

## Usage

```bash
claude-team                    # session interactive
claude-team -c                 # reprendre la dernière conversation
claude-team --model opus       # choisir le modèle
claude-team --print "..."      # mode non-interactif
```

Tous les flags de `claude` sont supportés.

## Désinstallation

```bash
rm ~/.local/bin/claude-team
```
