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
- `.testbed/tests/test_example.gd.uid`
- `.plans/2026-05-01-xr-shell-downscope-alignment.md`

**Status:** ❌ Audit found remaining repo-local hygiene gap

**Results:** Initial downscope wording cleanup landed, but retry verification found three concrete misses: `.testbed/addons.jsonc` still pinned stale `aerobeat-core`, `.testbed/tests/test_example.gd` was still placeholder boilerplate, and README validation notes still normalized that stale core pin as acceptable drift. The retry removed `aerobeat-core` from the committed XR shell manifest, replaced the placeholder test with repo-truth guardrails that assert future/third-wave XR positioning plus the shell-only dependency contract, and rewrote the README validation notes so they describe the cleaned shell boundary instead of excusing stale bootstrap drift. Retry validation passed via `godotenv addons install`, `godot --headless --path .testbed --import`, and the repo-local GUT suite. Implementation retry commit: `4ee1d0f` (`Fix XR shell downscope retry drift`). QA independently rechecked the repo against `aerobeat-docs` truth (`docs/api/ui/shell-xr-community/index.md`, `docs/gdd/concept.md`, `docs/guides/calibration.md`, `docs/guides/choreography/overview.md`, `docs/gdd/gameplay/boxing.md`, `docs/gdd/gameplay/flow.md`), confirmed the committed HEAD manifest no longer contains root-level `aerobeat-core`, and reran the same validation flow successfully. QA assessment: pass. The new tests are meaningful guardrails for this repo class because they now assert README/product-scope truth, plugin metadata truth, manifest boundary truth, and workbench naming truth; they are string-based and not exhaustive schema tests, but they materially protect against the exact stale drift that caused the retry. Final hygiene follow-up: ran the documented validation flow again, let Godot regenerate the canonical `.testbed/tests/test_example.gd.uid`, and committed that repo-local UID file as the narrowest truthful fix. Post-fix validation reran cleanly: `godotenv addons install`, `godot --headless --path .testbed --import`, and `godot --headless --path .testbed --script addons/gut/gut_cmdln.gd -gdir=res://tests -ginclude_subdirs -gexit` all passed; after the UID was committed, `git status --short` returned clean.

QA recheck on commit `18d9487` re-ran the documented validation flow from a clean checkout and re-verified the same truth surfaces independently. README truth matched the docs' PC-first / mobile-second / VR-third product direction; `plugin.cfg` stayed future/third-wave; `.testbed/addons.jsonc` stayed constrained to `aerobeat-ui-core`, `aerobeat-ui-kit-community`, and `gut`; `.testbed/project.godot` kept the future-workbench naming; `.testbed/tests/test_example.gd` and its committed `.uid` matched the intended guardrail/hygiene setup. Recheck validation again passed 4/4 GUT tests.

Audit spot-check on 2026-05-01 reran the same documented flow and got the expected accepted upstream/non-local GUT `ObjectDB instances leaked at exit` warning during `--import`, which remains non-blocking per the completed `oc-b7u` investigation and Derrick's explicit acceptance. However, the repo still fails the clean-tree completion bar for a different repo-local reason: `git status --porcelain=v1` reports `?? .plans/2026-05-01-xr-objectdb-warning-investigation.md`. That investigation plan contains accepted truth the audit was asked to rely on, but it is not committed or otherwise cleaned up, so a fresh checkout cannot reproduce the documented evidence surface. Bead should remain open until that untracked repo-local plan artifact is either committed truthfully or intentionally removed and its findings preserved elsewhere.

---

## Final Results

**Status:** ❌ Blocked in audit by remaining repo-local hygiene gap

**What We Built:** Narrowed the XR shell repo to truthful future-platform positioning without broadening scope, completed a retry pass that removed the stale root-level `aerobeat-core` manifest pin, replaced placeholder tests with real repo-truth guards, corrected README validation notes that previously normalized the stale dependency drift, and committed the canonical `.testbed/tests/test_example.gd.uid` generated by the documented Godot validation flow.

**Reference Check:** `REF-01`, `REF-02`, and `REF-03` are satisfied for wording/scope/dependency truth. Audit spot-checks against the downscoped docs confirmed the README, `plugin.cfg`, `.testbed/addons.jsonc`, `.testbed/project.godot`, `.testbed/tests/test_example.gd`, and `.testbed/tests/test_example.gd.uid` still align with the PC-first / mobile-second / VR-third product truth.

**Validation Check:** Audit reran the documented validation flow: `godotenv addons install`, `godot --headless --path .testbed --import`, and `godot --headless --path .testbed --script addons/gut/gut_cmdln.gd -gdir=res://tests -ginclude_subdirs -gexit`. Godot/GUT again passed 4/4 tests. The known `ObjectDB instances leaked at exit` warning still appears during `--import`, but `oc-b7u` isolated that to upstream/non-local GUT editor-plugin behavior and Derrick explicitly accepted it as non-blocking noise for now. The audit-blocking gap is different and repo-local: `git status --porcelain=v1` still reports `?? .plans/2026-05-01-xr-objectdb-warning-investigation.md`.

**Commits:**
- `7eb3221` - `Downscope XR shell repo truth`
- `4ee1d0f` - `Fix XR shell downscope retry drift`
- `42b2c6f` - `Commit XR test UID hygiene fix`
- `18d9487` - `Update XR hygiene plan notes`

**Lessons Learned:** In this repo class, the meaningful drift was mostly wording truth rather than implementation architecture. Repo-truth guard tests still need normal Godot hygiene, and audit closure also depends on durable repo evidence surfaces staying committed/clean. An accepted upstream warning does not block closure; an untracked repo-local plan artifact does.

---

*Updated on 2026-05-01; audit failed, bead remains open until the untracked investigation-plan artifact is resolved cleanly*
