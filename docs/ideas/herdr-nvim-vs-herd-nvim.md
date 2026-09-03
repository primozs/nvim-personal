# herdr-nvim vs herd.nvim (vs Sidekick)

Status: **idea / evaluation** — dogfood both plugins alongside Sidekick; decide keep/drop after checklist below. Not an ADR.

Branch: `herdr` in this nvim config.

## Problem Statement

**How might we** get reliable agent busy/idle/blocked awareness and a clean nvim↔agent loop — without abandoning Sidekick — by evaluating the two herdr-native Neovim plugins.

Motivating gaps Sidekick alone does not close well today:

- Real agent lifecycle (working / idle / blocked), not terminal heuristics
- Persistence of agent PTYs across nvim quit
- Optional herdr-first workspace (sidebar editor next to agents)

## Contenders

| | **herd.nvim** ([MomePP/herd.nvim](https://github.com/MomePP/herd.nvim)) | **herdr-nvim** ([ChmaraX/herdr-nvim](https://github.com/ChmaraX/herdr-nvim)) | **sidekick.nvim** (current) |
|---|---|---|---|
| Who hosts UI | **nvim** | **herdr** | **nvim** |
| Agents live in | herdr PTYs → nvim floats (or herdr tabs) | herdr panes; nvim is sidebar | nvim terminals (+ optional mux) |
| Core loop | spawn / toggle / send selection / picker / jump | toggle editor sidebar / agent-touched files / annotations → agent | toggle CLI / prompts / send context / search→qf |
| Needs herdr | yes (backend ≥ 0.7.5; we have 0.8.2) | yes (run *inside* herdr for full UX) | no |
| Closest to Sidekick? | **Yes** | No (inverted architecture) | — |

### herd.nvim — pluses / minuses

**+** Same job as Sidekick: drive agents from nvim.  
**+** Real herdr agent status in picker (`working` / idle / blocked).  
**+** Float mode: nvim need not live inside a herdr pane; agents survive float close / `:q`.  
**+** Send selection (+ path:line fence), diagnostics, jump-to-`path:line` → quickfix.  
**−** Hard dependency on herdr; Sidekick stays tool-agnostic.  
**−** Smaller project; default keys clash with LazyVim (`<leader>s`).

### herdr-nvim — pluses / minuses

**+** Best herdr-first UX: persistent per-tab nvim sidebar, agent-touched file picker, review annotations.  
**+** Mature / active.  
**−** Architecture is the **inverse** of Sidekick (editor inside mux).  
**−** Weak Sidekick substitute; strong herdr companion.  
**−** Full eval needs both halves: herdr plugin + nvim plugin.

## Recommended evaluation direction

Run **all three** for a short bake-off with **non-overlapping keymaps** (already wired on this branch):

| Plugin | Role in bake-off | Eval key namespace |
|--------|------------------|-------------------|
| Sidekick | Baseline / control | `<leader>ae*` (unchanged) |
| herd.nvim | Sidekick-shaped alternative | `<leader>hd*` / `<leader>h\` |
| herdr-nvim | herdr-first companion | `<leader>hn*` + herdr `prefix+e` / `prefix+o` |

Prefer **herd.nvim float mode** for the Sidekick comparison. Use **herdr-nvim** only when deliberately working inside a herdr session (sidebar / picker / annotations).

Do **not** treat herd native mode + herdr-nvim sidebar as day-one goals — that combination fights itself until one host wins.

## Key assumptions to validate

- [ ] herdr as a always-on daemon is acceptable friction vs Sidekick’s in-process terminals
- [ ] herd.nvim float UX is good enough to replace (or reduce) Sidekick CLI for pi / claude
- [ ] herdr’s native busy/idle/blocked is accurate enough that Sidekick `agent_status` work on branch `sidekick` is unnecessary
- [ ] herdr-nvim’s annotation → agent flow beats Sidekick “send this / selection” for review-style work
- [ ] Running both eval plugins does not corrupt Sidekick sessions or key muscle memory

## MVP scope (this bake-off)

**In**

- lazy.nvim specs for both plugins (coexistence-safe keys)
- herdr plugin install for `ChmaraX/herdr-nvim` (sidebar + picker)
- herd.nvim `mode = "float"` with `pi` (and optional `claude`) tools
- This ideas doc + checklist below

**Out**

- Replacing Sidekick permanently
- herd.nvim `mode = "native"` return-trip binding (optional later)
- Merging Sidekick `agent_status` into master
- Upstream PRs / forks

## Not doing (and why)

- **Default keymaps from either plugin** — collide with LazyVim / Sidekick / Pi (`<leader>s`, `<leader>a*`).
- **Dropping Sidekick during eval** — need a control; remove only after a clear win.
- **Enabling both as primary UX at once** — different hosts; pick scenarios per day, not one fused workflow.
- **Porting Sidekick search→qf into herdr plugins first** — evaluate stock features before custom glue.

## Eval checklist

### Day A — herd.nvim ≈ Sidekick

1. Start herdr server (`herdr` somewhere / headless).
2. In normal nvim (not inside herdr): `<leader>h\` spawn/toggle project agent float.
3. `<leader>hs` picker — confirm status labels look right while agent works / finishes / blocks.
4. Visual select → `<leader>h\` send (no Enter); submit manually; confirm context fence.
5. `:Herd jump` after agent prints `path:line` — qf useful?
6. Quit nvim, reopen — agent still attached via herdr? Toggle float again.
7. Parallel: same task with Sidekick `<leader>aa` / `<leader>aet` — note friction wins/losses.

### Day B — herdr-nvim ≈ herdr companion

1. Work inside a herdr session; `prefix+e` toggle nvim sidebar; `prefix+o` agent-touched picker.
2. Annotate with `<leader>hnc` / `<leader>hnl`; send with `<leader>hns` / `<leader>hnS`.
3. Confirm annotations clear after send; statusline `require("herdr-nvim").statusline()` if desired.
4. Compare to Sidekick send-selection for the same review comment workflow.

### Decision gate

Pick one:

- **Keep herd.nvim**, drop herdr-nvim — nvim remains host; herdr is PTY/status backend.
- **Keep herdr-nvim**, drop herd.nvim — commit to herdr-first desktop; Sidekick secondary.
- **Keep neither** — stick with Sidekick (+ maybe `sidekick` branch agent_status / pi-notify).
- **Keep both narrowly** — herd for Sidekick-like days; herdr-nvim only inside herdr sessions (document when).

Record the choice and date at the bottom when done.

## Coexistence notes

- herd.nvim float mode and herdr-nvim’s **nvim annotation half** can load together; herdr-nvim’s **sidebar/picker** need a herdr session.
- herd.nvim native mode + herdr-nvim sidebar is possible in theory but high cognitive load — defer.
- Sidekick keys stay on `<leader>ae*`; Pi search stays on `<leader>aS`.

## Open questions

- Is `pi` / `pi-hub` a first-class `herdr agent start --kind` for herd.nvim, or do we need `kind` overrides?
- Prefer herdr status over continuing Sidekick `agent_status` on branch `sidekick`?
- Worth a thin glue later: Sidekick search→qf style jump using herd’s `:Herd jump` only?

## Decision

_Pending bake-off._

<!-- When decided: date, choice, one-paragraph why, what to delete from this branch. -->
