---
title: Caveman OpenCode Local Skill Installation
date: 2026-04-11
status: approved
---

# Caveman OpenCode Local Skill Installation

## Goal

Make the `caveman` skill available to OpenCode by installing it into a local skill directory that OpenCode already indexes.

## Context

The `caveman` plugin is present in Claude plugin cache under `~/.claude/plugins/cache/...`, but this OpenCode session only advertises skills from indexed local skill directories such as `~/.claude/skills` and `~/.config/opencode/skills`.

Because `caveman` is not present in either indexed directory, it is not exposed through the `skill` tool in this session.

## Chosen Approach

Install `caveman` manually into `~/.claude/skills/caveman/SKILL.md`.

This is the preferred approach because:

- it matches the existing personal skill directory already used on this machine
- it is the smallest possible change
- it avoids depending on hashed plugin cache paths that may change on update
- the `caveman` skill is self-contained and does not require supporting files for basic use

## Alternatives Considered

### Copy all Caveman repo skills

Copying `caveman-commit`, `caveman-review`, and `compress` alongside `caveman` would expose more functionality, but it is broader than the current need.

### Symlink from plugin cache

Symlinking from the cached plugin skill path would avoid duplication, but the cache path contains versioned directories and is more fragile across plugin updates.

## Target File Layout

```text
~/.claude/skills/
  caveman/
    SKILL.md
```

## Installation Steps

1. Create `~/.claude/skills/caveman/` if it does not already exist.
2. Copy the contents of the repo's `skills/caveman/SKILL.md` into `~/.claude/skills/caveman/SKILL.md`.
3. Verify the file exists and contains valid skill frontmatter.
4. Start a new OpenCode session so the runtime rebuilds the advertised skill list.

## Expected Result

On a fresh session, OpenCode should discover `caveman` from `~/.claude/skills/caveman/SKILL.md` and expose it as a loadable skill.

## Constraints

- The current session's `available_skills` list is fixed at startup.
- Copying the skill file during this session does not guarantee this same session can invoke it immediately.
- Plugin hook behavior from Claude Code remains separate from manual skill loading in OpenCode.

## Verification Plan

- Confirm `~/.claude/skills/caveman/SKILL.md` exists.
- Confirm the file begins with valid YAML frontmatter containing `name` and `description`.
- In a fresh session, confirm `caveman` appears in the skill registry and can be loaded by name.
