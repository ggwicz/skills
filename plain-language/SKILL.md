---
name: plain-language
description: >-
  Reviews project text — documentation, READMEs, marketing copy, UI strings,
  code comments, error messages — for compliance with the U.S. federal
  government Plain Language Guidelines. Produces structured edit
  recommendations with concrete rewrites. Activates on plain language
  review, readability check, copy audit, "make this clearer," or
  "improve the writing."
allowed-tools: Read Write Glob Grep Bash(scripts/scan-files.sh:*)
---

# Plain Language Review

Review text files against the U.S. federal government Plain Language Guidelines (~30 rules across 6 categories) and produce a structured report of findings with concrete rewrites.

**Important: This skill produces a report. Do not modify any reviewed files.**

---

## Review Workflow

1. **Select files** — Use the user's specified files. If none specified, run `scripts/scan-files.sh <project-directory>` to discover all `.md`, `.mdx`, `.txt`, `.rst`, and `.adoc` files. The `<project-directory>` argument is **required** — it must be the root of the user's project (the repository being reviewed), NOT the skill's own directory.
2. **Load rules** — Read `references/rules-quick-ref.md` for the full rule checklist.
3. **Review each file** — For each file, read it and apply all rules. Skip text inside code blocks/fences, inline code, and code-only files. Only review human-readable prose.
4. **Generate findings** — For each issue found, produce a finding using the Output Format below.
5. **Classify severity** — Use `references/severity-rubric.md` to assign high/medium/low.
6. **Verify rewrites** — For each suggested rewrite, confirm it resolves the flagged rule violation and does not introduce new violations. If a rewrite still triggers the same or a different rule, revise it before including it in the report.
7. **Assemble report** — Write findings to `plain-language-findings-YYYYMMDD.md` in the project root (use today's date). Group findings by file, then by severity (high first). End with the summary block.

---

## Output Format

Use this exact structure for each finding:

```
## [file path]

### Finding [N] — [Rule name] (severity: [high|medium|low])
- **Line [N]:** "[original text]"
- **Guideline:** [One-sentence explanation of the rule violated]
- **Suggested:** "[concrete rewrite]"
```

**Example:**

```
## docs/getting-started.md

### Finding 1 — Use simple words (severity: medium)
- **Line 14:** "In order to utilize the configuration module..."
- **Guideline:** Replace complex words with simple alternatives — "utilize" → "use", "in order to" → "to"
- **Suggested:** "To use the configuration module..."

### Finding 2 — Use active voice (severity: high)
- **Line 23:** "The database will be initialized by the setup script."
- **Guideline:** Make the actor the subject of the sentence
- **Suggested:** "The setup script initializes the database."
```

If a file has no findings, omit it from the report entirely — do not list it.

End the report with a summary:

```
## Summary
- **Files reviewed:** [N]
- **Total findings:** [N] ([N] high, [N] medium, [N] low)
- **Top issues:** [List the 2-3 most frequent rule violations]
```

---

## When to Load Reference Files

Load references on demand to conserve context:

| File | When to load |
|------|-------------|
| `references/rules-quick-ref.md` | Always — load at start of every review |
| `references/word-substitutions.md` | When checking word choice or when you encounter a word that might have a simpler alternative |
| `references/active-voice-guide.md` | When you detect passive voice patterns (forms of "to be" + past participle) |
| `references/before-and-after-examples.md` | When crafting suggested rewrites — use as transformation models |
| `references/severity-rubric.md` | When classifying findings — consult definitions and examples |

---

## Scope Rules

- **Review:** prose in `.md`, `.mdx`, `.txt`, `.rst`, `.adoc` files; comments in source code files; UI strings; error messages
- **Skip:** code inside fences/backticks, variable names, import statements, configuration values, URLs, file paths
- **Preserve technical terms** — flag jargon only when a simpler alternative exists without losing precision
- **Do not modify reviewed files** — produce recommendations only

---

## Attribution

The plain language guidelines and examples referenced by this skill originate from the U.S. federal government's Plain Language initiative, maintained by the General Services Administration (GSA). All guideline content is U.S. government work in the public domain. Source: https://digital.gov/guides/plain-language
