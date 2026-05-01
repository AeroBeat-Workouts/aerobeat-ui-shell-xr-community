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

**Results:** Audited the repo against the downscoped AeroBeat docs truth and found a narrow, repo-local drift class: the repo was structurally minimal and already package-shaped, but its human-facing shell wording still read like a neutral active platform repo instead of a future/third-wave XR path. Updated the README, plugin manifest, testbed manifest comments, and testbed project name so the repo now explicitly matches the locked sequencing from `REF-02`: PC-first camera gameplay first, mobile later, XR/VR after that. Validation passed via `godotenv addons install`, `godot --headless --path .testbed --import`, and the repo-local GUT suite. No additional repo-local implementation scope or follow-up bead was required from this audit pass.

---

## Final Results

**Status:** ✅ Complete

**What We Built:** Narrowed the XR shell repo to truthful future-platform positioning without broadening scope. The repo now states clearly that it is a future / third-wave VR-return shell, while the active AeroBeat v1 story remains PC-first camera gameplay (`boxing` + `flow`). The repo-local dependency/testbed surfaces were kept aligned to that story rather than implying current platform parity.

**Reference Check:** `REF-01`, `REF-02`, and `REF-03` satisfied. The README and testbed/manifest wording now match the downscoped docs truth for PC-first camera v1, mobile second, and XR later; no conflicting repo-local package metadata remained after the pass.

**Commits:**
- `7eb3221` - `Downscope XR shell repo truth`

**Lessons Learned:** In this repo class, the meaningful drift was mostly wording truth rather than implementation architecture. The important thing was to make the hidden workbench and manifest comments tell the same product-scope story as the public README.

---

*Completed on 2026-05-01*
