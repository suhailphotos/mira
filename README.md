# Mira — Neovim theme scaffold (multi-variant)

**One‑liner:** *Mira — a Neovim theme with multiple variants; simple load in Neovim, palette generation automated in‑repo.*

This repository is only the **scaffold**: folders, placeholders, and a clean place to add your generators and palettes.
For now, only this `README.md` and the `.gitignore` will contain content. Everything else is empty on purpose.

## Goals
- Keep the Neovim side minimal (just `require("mira").load("<variant>")` later).
- Do all palette logic, mapping, and terminal exports **inside this repo**.
- Support multiple variants from a single brand name (**Mira**).

## Directory layout (scaffold)
```
mira/
├─ README.md              # this file
├─ .gitignore
├─ palettes/              # source YAMLs for variants (empty now)
├─ tools/                 # generators & templates (empty)
│  └─ templates/          # Jinja or other templates (empty)
├─ scripts/               # helper scripts (empty)
├─ colors/                # generated Neovim colors (empty)
├─ lua/
│  └─ mira/               # runtime files emitted/generated later (empty)
├─ plugin/                # nvim :Mira command wiring (empty)
├─ ghostty/
│  └─ themes/             # generated Ghostty presets (empty)
├─ iterm/                 # generated iTerm2 .itermcolors (empty)
├─ tmux/                  # generated tmux snippets (empty)
└─ blink/
   └─ themes/             # generated Blink JS themes (empty)
```

> **Note:** Empty folders are tracked with `.gitkeep` files so the structure survives in Git.

## Next steps (later)
- Author palettes in `palettes/*.yml`.
- Implement generators under `tools/` (e.g., `tools/gen.py`) to emit:
  - `lua/mira/flavors.lua`, `colors/mira-*.lua`
  - `ghostty/themes/*`, `iterm/*.itermcolors`, `tmux/*`, `blink/themes/*`
- Hook up a tiny runtime loader in `lua/mira/` once variants are ready.

## License
Planned: MIT (add a `LICENSE` file later).
