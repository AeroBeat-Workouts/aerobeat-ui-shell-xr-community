# aerobeat-ui-shell-xr-community

**Date:** 2026-05-01  
**Status:** In Progress  
**Agent:** Chip 🐱‍💻

---

## Goal

Align `aerobeat-ui-shell-xr-community` with the locked AeroBeat v1 downscope so it truthfully presents itself as a future/third-wave community shell, not a current parity target.

---

## Overview

This repo is part of the AeroBeat UI shell layer follow-up from the parent coordination plan in `openclaw-chip`. The work should stay narrow: inspect README/package/testbed/manifest/dependency surfaces, remove stale scope claims, and ensure this shell's positioning matches the downscoped docs truth.

Do not silently widen scope. If the repo exposes cross-repo fallout or deeper implementation work, record it explicitly and create follow-up Beads instead of hiding it inside this pass.

---

## REFERENCES

| ID | Description | Path |
| --- | --- | --- |
| `REF-01` | Parent AeroBeat coordination plan | `/home/derrick/.openclaw/workspace/projects/openclaw-chip/.plans/2026-05-01-aerobeat-ui-shell-downscope-pass.md` |
| `REF-02` | Downscoped docs source of truth | `/home/derrick/.openclaw/workspace/projects/aerobeat/aerobeat-docs` |
| `REF-03` | Owning repo | `/home/derrick/.openclaw/workspace/projects/aerobeat/aerobeat-ui-shell-xr-community` |

---

## Tasks

### Task 1: Audit and align repo truth

**Bead ID:** `oc-y1i`  
**SubAgent:** `primary`  
**Role:** `coder`  
**References:** `REF-01`, `REF-02`, `REF-03`  
**Prompt:** Claim the assigned bead, audit the repo against the downscoped AeroBeat docs truth, implement the required alignment changes, run relevant validation, commit/push to `main`, and leave concise handoff notes for QA.

**Folders Created/Deleted/Modified:**
- `.plans/`
- `.testbed/`

**Files Created/Deleted/Modified:**
- `README.md`
- `plugin.cfg`
- `.testbed/addons.jsonc`
- `.testbed/project.godot`
- `.plans/2026-05-01-xr-shell-downscope-alignment.md`

**Status:** ✅ Complete

**Results:** Initial downscope wording cleanup landed, but retry verification found three concrete misses: `.testbed/addons.jsonc` still pinned stale `aerobeat-core`, `.testbed/tests/test_example.gd` was still placeholder boilerplate, and README validation notes still normalized that stale core pin as acceptable drift. The retry removed `aerobeat-core` from the committed XR shell manifest, replaced the placeholder test with repo-truth guardrails that assert future/third-wave XR positioning plus the shell-only dependency contract, and rewrote the README validation notes so they describe the cleaned shell boundary instead of excusing stale bootstrap drift. Retry validation passed via `godotenv addons install`, `godot --headless --path .testbed --import`, and the repo-local GUT suite. Implementation retry commit: `4ee1d0f` (`Fix XR shell downscope retry drift`).

---

## Final Results

**Status:** ✅ Complete

**What We Built:** Narrowed the XR shell repo to truthful future-platform positioning without broadening scope, then completed a retry pass that removed the stale root-level `aerobeat-core` manifest pin, replaced placeholder tests with real repo-truth guards, and corrected README validation notes that previously normalized the stale dependency drift. The repo now states clearly that it is a future / third-wave VR-return shell, while the active AeroBeat v1 story remains PC-first camera gameplay (`boxing` + `flow`).

**Reference Check:** `REF-01`, `REF-02`, and `REF-03` satisfied. The README and testbed/manifest wording now match the downscoped docs truth for PC-first camera v1, mobile second, and XR later; the committed XR shell manifest now contains only `aerobeat-ui-core`, `aerobeat-ui-kit-community`, and `gut`, and the repo-local GUT tests enforce that shell boundary.

**Commits:**
- `7eb3221` - `Downscope XR shell repo truth`
- `4ee1d0f` - `Fix XR shell downscope retry drift`

**Lessons Learned:** In this repo class, the meaningful drift was mostly wording truth rather than implementation architecture. The important thing was to make the hidden workbench and manifest comments tell the same product-scope story as the public README.

---

*Completed on 2026-05-01*
