# claude-team

Launches Claude Code with the experimental teams mode enabled.

## What it does

- Enables `CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS=1`
- Displays "Claude Team" in the terminal window/tab title
- Forwards all arguments to `claude` unchanged

## Installation

```bash
./install.sh
```

Creates a symlink `~/.local/bin/claude-team` → this directory.
`~/.local/bin` must be in your `PATH` (which is already the case if `claude` works).

## Usage

```bash
claude-team                    # interactive session
claude-team -c                 # resume the last conversation
claude-team --model opus       # choose the model
claude-team --print "..."      # non-interactive mode
```

All `claude` flags are supported.

## Uninstall

```bash
rm ~/.local/bin/claude-team
```
