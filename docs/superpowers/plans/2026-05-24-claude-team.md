# claude-team Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Créer la commande `claude-team` — un wrapper bash qui lance Claude Code avec `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1` et affiche "Claude Team" dans le titre de la fenêtre terminal.

**Architecture:** Un script bash unique utilisant `exec` pour remplacer le shell courant par `claude`, ce qui garantit une transmission propre des signaux. Un `install.sh` crée un symlink dans `~/.local/bin/` afin que la commande soit disponible globalement sans copier le fichier.

**Tech Stack:** Bash, symlink POSIX, séquence ANSI OSC 0 pour le titre de fenêtre.

---

## Fichiers à créer

| Fichier | Rôle |
|---|---|
| `claude-team` | Script principal exécutable |
| `install.sh` | Crée le symlink dans `~/.local/bin/` |
| `README.md` | Usage, installation, désinstallation |

---

### Task 1 : Script principal `claude-team`

**Files:**
- Create: `claude-team`

- [ ] **Step 1 : Écrire le script**

Créer le fichier `claude-team` à la racine du projet avec ce contenu exact :

```sh
#!/usr/bin/env bash
printf '\033]0;Claude Team\007'
CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1 exec claude "$@"
```

- [ ] **Step 2 : Rendre le script exécutable**

```bash
chmod +x claude-team
```

Vérification :

```bash
ls -la claude-team
```

Résultat attendu : `-rwxr-xr-x` (le bit x est présent).

- [ ] **Step 3 : Vérifier la syntaxe bash**

```bash
bash -n claude-team && echo "OK"
```

Résultat attendu : `OK` (aucune erreur de syntaxe).

- [ ] **Step 4 : Commit**

```bash
git add claude-team
git commit -m "feat: add claude-team wrapper script"
```

---

### Task 2 : Script d'installation `install.sh`

**Files:**
- Create: `install.sh`

- [ ] **Step 1 : Écrire install.sh**

Créer le fichier `install.sh` avec ce contenu exact :

```sh
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
```

- [ ] **Step 2 : Rendre install.sh exécutable**

```bash
chmod +x install.sh
```

- [ ] **Step 3 : Vérifier la syntaxe**

```bash
bash -n install.sh && echo "OK"
```

Résultat attendu : `OK`.

- [ ] **Step 4 : Commit**

```bash
git add install.sh
git commit -m "feat: add install script (symlink to ~/.local/bin/)"
```

---

### Task 3 : README.md

**Files:**
- Create: `README.md`

- [ ] **Step 1 : Écrire le README**

Créer `README.md` avec ce contenu :

```markdown
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
```

- [ ] **Step 2 : Commit**

```bash
git add README.md
git commit -m "docs: add README with install and usage instructions"
```

---

### Task 4 : Installation et vérification

- [ ] **Step 1 : Lancer install.sh**

```bash
./install.sh
```

Résultat attendu :

```
Installé : /Users/<toi>/.local/bin/claude-team -> /Users/<toi>/Documents/dev/lubbee/claude-team/claude-team
```

- [ ] **Step 2 : Vérifier le symlink**

```bash
ls -la ~/.local/bin/claude-team
```

Résultat attendu : `lrwxr-xr-x ... claude-team -> .../lubbee/claude-team/claude-team`

- [ ] **Step 3 : Vérifier que la commande est trouvée dans le PATH**

```bash
which claude-team
```

Résultat attendu : `/Users/<toi>/.local/bin/claude-team`

- [ ] **Step 4 : Test de smoke — vérifier le passage d'arguments**

```bash
claude-team --version
```

Résultat attendu : même sortie que `claude --version` (ex. `2.1.150 (Claude Code)`).

- [ ] **Step 5 : Test du titre de fenêtre**

Lancer `claude-team` dans le terminal. Le titre de l'onglet ou de la fenêtre doit afficher **"Claude Team"** (visible dans la barre de titre iTerm2/Terminal.app/Ghostty).

- [ ] **Step 6 : Test avec argument**

```bash
claude-team --print "Réponds juste OK"
```

Résultat attendu : `claude` répond normalement, comme si on avait tapé `claude --print "Réponds juste OK"`.

- [ ] **Step 7 : Commit final**

```bash
git add -A
git status  # vérifier qu'il n'y a rien d'oublié
git commit -m "chore: verify installation complete" --allow-empty
```

> Note : si rien n'est stagé (tous les fichiers déjà commités), passer ce step.
