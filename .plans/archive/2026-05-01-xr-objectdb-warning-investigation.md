# aerobeat-ui-shell-xr-community

**Date:** 2026-05-01  
**Status:** Complete  
**Agent:** Chip 🐱‍💻

---

## Goal

Investigate the recurring `ObjectDB instances leaked at exit` warning during the XR shell headless GUT flow, identify the actual source, and fix it if the fix is narrow and repo-local.

---

## Overview

The XR shell downscope work is functionally complete and the repo now stays clean after validation, but the headless Godot + GUT flow still emits an `ObjectDB instances leaked at exit` warning. Derrick wants that investigated and fixed before we move web or the wider shell wave forward.

This should be handled as a focused repo-local debugging slice in `aerobeat-ui-shell-xr-community`, not as vague “runtime noise.” The work needs to distinguish between: a leak in our test file, a leak in repo/plugin/testbed setup, a GUT harness issue, or a dependency/addon/plugin lifecycle issue. We should not guess. We should reproduce the warning, narrow the source, apply the smallest truthful fix, and then rerun the documented validation flow to confirm the warning is gone and the repo remains clean.

If the warning turns out to come from upstream GUT/Godot/addon behavior that cannot be fixed cleanly in this repo, the result should be an explicit documented finding with evidence and a scoped follow-up bead rather than silent hand-waving.

---

## REFERENCES

| ID | Description | Path |
| --- | --- | --- |
| `REF-01` | Parent shell downscope coordination plan | `/home/derrick/.openclaw/workspace/projects/openclaw-chip/.plans/2026-05-01-aerobeat-ui-shell-downscope-pass.md` |
| `REF-02` | XR shell downscope repo-local plan | `/home/derrick/.openclaw/workspace/projects/aerobeat/aerobeat-ui-shell-xr-community/.plans/2026-05-01-xr-shell-downscope-alignment.md` |
| `REF-03` | XR shell repo | `/home/derrick/.openclaw/workspace/projects/aerobeat/aerobeat-ui-shell-xr-community` |
| `REF-04` | Downscoped docs truth | `/home/derrick/.openclaw/workspace/projects/aerobeat/aerobeat-docs` |

---

## Tasks

### Task 1: Reproduce and isolate the ObjectDB leak warning source

**Bead ID:** `oc-b7u`  
**SubAgent:** `primary`  
**Role:** `research`  
**References:** `REF-02`, `REF-03`  
**Prompt:** Claim bead `oc-b7u`, reproduce the `ObjectDB instances leaked at exit` warning in the XR shell testbed, then isolate whether it comes from the repo test file, plugin/testbed setup, GUT, or another addon/dependency. Record concrete reproduction evidence, the likely source, and the smallest truthful next fix.

**Folders Created/Deleted/Modified:**
- `.plans/`

**Files Created/Deleted/Modified:**
- `.plans/2026-05-01-xr-objectdb-warning-investigation.md`

**Status:** ✅ Complete

**Results:** Reproduced the warning exactly with the documented flow from `REF-03`: `(cd .testbed && godotenv addons install)`, `godot --headless --path .testbed --import`, and `godot --headless --path .testbed --script addons/gut/gut_cmdln.gd -gdir=res://tests -ginclude_subdirs -gexit`. The warning appears during the `--import` step before the repo-local test suite runs: `WARNING: ObjectDB instances leaked at exit` with `Leaked instance: SceneTreeTimer...`. Running `--import --verbose` showed the leak happens while the GUT editor plugin is initialized/unloaded, not while our test file runs.

Isolation experiments narrowed the source further:
- **Repo test file not required:** a scratch copy of the workbench with an empty `tests/` directory and only the `gut` addon still leaked the same `SceneTreeTimer` on `godot --headless --import`.
- **Repo/plugin shell code not required:** a brand-new minimal Godot project in `/tmp/oc-b7u-scratch/gut_enabled` with only `addons/gut` copied in and `enabled=PackedStringArray("res://addons/gut/plugin.cfg")` reproduced the leak; a sibling plain project with no GUT plugin did not leak.
- **Exact trigger isolated:** patching only `addons/gut/gut_plugin.gd` in the scratch project to remove `await get_tree().create_timer(1).timeout` from `_enter_tree()` made the warning disappear under the same `--import` flow.

Most likely source: `REF-03/.testbed/addons/gut/gut_plugin.gd` upstream plugin behavior, specifically the awaited one-second `SceneTreeTimer` in the GUT editor plugin `_enter_tree()` path during headless import/exit. This matches the observed leak type and is consistent with upstream Godot behavior around awaited `SceneTreeTimer`s during quit (`godotengine/godot#79669`). Recommended next fix: do **not** broad-brush the repo testbed; either (a) carry a narrow repo-local patch to the installed GUT plugin removing/reworking that await for headless import, or preferably (b) treat this as upstream/non-local and track a scoped follow-up against GUT (or a pinned local fork) because the minimal reproduction no longer depends on this repo’s XR shell code or tests.

---

### Task 2: Apply the narrowest truthful fix and revalidate

**Bead ID:** `Pending`  
**SubAgent:** `primary`  
**Role:** `coder`  
**References:** `REF-02`, `REF-03`  
**Prompt:** Using the Task 1 findings, apply the narrowest truthful repo-local fix for the ObjectDB leak warning if possible, rerun the documented validation flow, confirm whether the warning is gone and the repo stays clean, then update the plan and commit/push the result. If the warning is not fixable repo-locally, document that with evidence and create a scoped follow-up bead.

**Folders Created/Deleted/Modified:**
- `Pending investigation`

**Files Created/Deleted/Modified:**
- `Pending investigation`

**Status:** ⏳ Pending

**Results:** Pending.

---

## Final Results

**Status:** ✅ Complete

**What We Built:** A completed investigation with a minimal reproduction and source isolation for the `ObjectDB instances leaked at exit` warning. The warning is reproducible in the repo’s documented XR validation flow, but the evidence points away from repo-local XR shell code/tests and toward GUT editor-plugin startup behavior during headless import.

**Reference Check:** `REF-02` and `REF-03` were validated directly by rerunning the documented workbench flow and then reducing the setup to scratch projects. No downscope truth drift was found; this is a test-tooling/runtime issue.

**Commits:**
- None in this investigation pass.

**Lessons Learned:** For Godot headless validation, `--import` can exercise editor plugins and produce shutdown-time leak warnings that are unrelated to repo-local test logic. The narrowest trustworthy path is to reduce to a scratch project and prove whether the warning follows the addon/plugin alone before changing repo code. Derrick explicitly accepted this warning as non-blocking upstream noise for now, so no repo-local patch will be pursued in this slice.

---

*Updated on 2026-05-01; investigation complete, bead remains open for follow-up fix decision*
