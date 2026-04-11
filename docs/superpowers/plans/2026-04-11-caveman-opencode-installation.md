# Caveman OpenCode Installation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the `caveman` skill loadable by OpenCode by placing it in `~/.claude/skills/caveman/SKILL.md` and verifying the local install.

**Architecture:** This is a minimal local-skill installation. Copy the self-contained `caveman` skill from the existing plugin cache into the personal skill directory that OpenCode already indexes, then verify the installed file and document the restart requirement for discovery.

**Tech Stack:** Local filesystem, OpenCode skill loader, Claude plugin cache, git

---

## File Structure

- Create: `~/.claude/skills/caveman/SKILL.md`
- Modify: none
- Verify: `docs/superpowers/specs/2026-04-11-caveman-opencode-design.md`

### Task 1: Install Local Caveman Skill

**Files:**
- Create: `~/.claude/skills/caveman/SKILL.md`
- Source: `~/.claude/plugins/cache/caveman/caveman/92f892f2b997/plugins/caveman/skills/caveman/SKILL.md`

- [ ] **Step 1: Verify source skill exists**

Run:

```bash
test -f /Users/thongnguyen/.claude/plugins/cache/caveman/caveman/92f892f2b997/plugins/caveman/skills/caveman/SKILL.md
```

Expected: command exits successfully with no output.

- [ ] **Step 2: Verify target directory exists**

Run:

```bash
test -d /Users/thongnguyen/.claude/skills/caveman
```

Expected: command exits successfully with no output.

- [ ] **Step 3: Copy the source skill into the local OpenCode-visible skill directory**

Run:

```bash
cp /Users/thongnguyen/.claude/plugins/cache/caveman/caveman/92f892f2b997/plugins/caveman/skills/caveman/SKILL.md /Users/thongnguyen/.claude/skills/caveman/SKILL.md
```

Expected: command exits successfully with no output.

- [ ] **Step 4: Verify installed file content starts with valid skill frontmatter**

Run:

```bash
head -n 8 /Users/thongnguyen/.claude/skills/caveman/SKILL.md
```

Expected output includes:

```text
---
name: caveman
description: >
```

- [ ] **Step 5: Verify installed file matches source exactly**

Run:

```bash
cmp /Users/thongnguyen/.claude/plugins/cache/caveman/caveman/92f892f2b997/plugins/caveman/skills/caveman/SKILL.md /Users/thongnguyen/.claude/skills/caveman/SKILL.md
```

Expected: command exits successfully with no output.

- [ ] **Step 6: Commit only if repository files changed as part of plan artifacts**

Run:

```bash
git status --short
```

Expected: no new repo file changes from the skill copy itself, because the install target is outside the repository. If plan/spec artifacts changed, commit only those repo files with a docs commit.

### Task 2: Verify Discovery Conditions And Handoff

**Files:**
- Verify: `~/.claude/skills/caveman/SKILL.md`
- Verify: `docs/superpowers/specs/2026-04-11-caveman-opencode-design.md`

- [ ] **Step 1: Confirm local skill file is in an indexed skill directory**

Run:

```bash
ls /Users/thongnguyen/.claude/skills/caveman
```

Expected output:

```text
SKILL.md
```

- [ ] **Step 2: Confirm current session still cannot rely on dynamic skill registry refresh**

Check the current session context and note that `available_skills` was populated at startup. No command required; this is a runtime constraint already established in the spec.

Expected: conclude that a fresh session is required for reliable discovery.

- [ ] **Step 3: Prepare exact user verification instruction for next session**

Use this message:

```text
Start a fresh OpenCode session, then ask it to use the `caveman` skill. If the runtime re-indexed `~/.claude/skills`, `caveman` should appear in the available skill list and become loadable by name.
```

- [ ] **Step 4: Optional follow-up if discovery still fails**

Run in the next debugging session:

```bash
ls /Users/thongnguyen/.claude/skills
ls /Users/thongnguyen/.config/opencode/skills
```

Expected: `caveman` appears under `~/.claude/skills`. If not visible to the runtime, the next investigation target is OpenCode's startup indexing behavior rather than file placement.

## Self-Review

- Spec coverage: the plan covers file placement, verification, and the restart requirement from the approved spec.
- Placeholder scan: no TODO/TBD markers or vague implementation language remain.
- Type consistency: all paths, filenames, and skill names match the approved spec and observed plugin cache path.
