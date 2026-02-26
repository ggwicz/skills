# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This project groups changes by date (YYYY-MM-DD) instead of version numbers.

## [2026-02-25]

### Added

- Scan `.markdown`, `.rtf`, `.org`, and `.wiki` files in the plain-language skill.
- Save plain-language findings in dated report files.
- Add the `code-hygiene` skill. It detects 10 common code smells and saves findings in dated reports.
- Add a script to find code files. It uses a blocklist to ignore binary files.
- Add detection tables and a severity rubric for the `code-hygiene` skill.
- Add reference files for the 10 code smells. The skill loads these files only when it needs them.
- Add a README file for the `code-hygiene` skill.
- Add the `code-hygiene` skill to the main skills list.

### Changed

- Change the skills list format in `README.md` from a table to a standard Markdown list.
- Rename the `code-hygiene` scanner script to `scan-source-files.sh`.
- Change scripts to use `bash`.
- Rewrite the `plain-language` description in the third person. Allow the skill to use write, glob, and grep tools.

### Removed

- Remove the duplicated "Dirty Dozen" table from the word substitutions file.
- Remove the duplicated "Key Rules by Priority" section from the `plain-language` skill.
- Remove old metadata from the `code-hygiene` skill.

## [2026-02-16]

### Added

- Add the `plain-language` skill. It reviews text against U.S. federal Plain Language guidelines.
- Add a GitHub Actions workflow and pre-commit hooks.
- Add a list of allowed tools and a read-only rule to the `plain-language` skill.
- Check suggested rewrites for mistakes before adding them to the report.
- Add the "Dirty Dozen" table to the rules quick reference.
- Add examples for developer content, such as API docs and error messages.

### Changed

- Skip files with no findings in the plain-language report.
- Parse YAML frontmatter correctly in validation scripts.

### Fixed

- Ignore hidden directories (like `.git` and `.venv`) in the file scanner.
- Require a project directory argument when you run the file scanner.
