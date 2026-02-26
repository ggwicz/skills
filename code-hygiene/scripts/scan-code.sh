#!/bin/sh
# scan-code.sh — Find reviewable source code files in a project directory.
#
# Strategy: blocklist/exclusion, not allowlist.
#   1. Use `git ls-files` if inside a git repo (respects .gitignore automatically)
#   2. Fall back to `find` with common exclusions for non-git directories
#   3. Exclude binary files (via `file --mime-encoding`)
#   4. Exclude known non-code text files (config, data, docs, lockfiles)
#   5. Separate test files from application files
#
# Outputs two sections separated by a "--- test files ---" marker.
# Usage: scan-code.sh <directory>

set -e

if [ -z "$1" ]; then
  echo "Usage: scan-code.sh <project-directory>" >&2
  echo "Error: project directory argument is required." >&2
  exit 1
fi

TARGET_DIR="$1"

# --- Step 1: Discover candidate files ---

if git -C "$TARGET_DIR" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  # Git repo: use tracked files (respects .gitignore automatically)
  CANDIDATES=$(git -C "$TARGET_DIR" ls-files --cached --others --exclude-standard | \
    sed "s|^|$TARGET_DIR/|")
else
  # Non-git: find all files, excluding common noise directories
  CANDIDATES=$(find "$TARGET_DIR" \
    -type d \( \
      -name '.*' -o \
      -name node_modules -o \
      -name vendor -o \
      -name __pycache__ -o \
      -name dist -o \
      -name build -o \
      -name coverage -o \
      -name venv -o \
      -name target -o \
      -name generated -o \
      -name '.git' \
    \) -prune -o \
    -type f -print)
fi

# --- Step 2: Exclude non-code text files (config, data, docs, lockfiles) ---

EXCLUDE_EXTENSIONS='\.json$|\.ya?ml$|\.toml$|\.ini$|\.cfg$|\.conf$|\.lock$|\.csv$|\.tsv$|\.xml$|\.svg$|\.html?$|\.css$|\.scss$|\.sass$|\.less$|\.md$|\.mdx$|\.txt$|\.rst$|\.adoc$|\.log$|\.env$|\.pem$|\.crt$|\.key$|\.ico$|\.png$|\.jpe?g$|\.gif$|\.webp$|\.woff2?$|\.ttf$|\.eot$|\.map$|\.min\.js$|\.min\.css$|\.d\.ts$|\.snap$'

TEXT_FILES=$(echo "$CANDIDATES" | grep -vE "$EXCLUDE_EXTENSIONS" || true)

# --- Step 3: Exclude binary files ---

ALL_FILES=""
for f in $TEXT_FILES; do
  # Skip if file doesn't exist (deleted but tracked) or is not a regular file
  [ -f "$f" ] || continue
  # Skip binary files: --mime-encoding reports "binary" for non-text
  ENCODING=$(file -b --mime-encoding "$f" 2>/dev/null)
  case "$ENCODING" in
    binary) continue ;;
  esac
  ALL_FILES="$ALL_FILES
$f"
done

# Trim leading blank line and sort
ALL_FILES=$(echo "$ALL_FILES" | sed '/^$/d' | sort)

# --- Step 4: Separate test files from application files ---

TEST_FILES=$(echo "$ALL_FILES" | grep -E '(_test\.|\.test\.|\.spec\.|/tests?/|/__tests__/)' || true)
APP_FILES=$(echo "$ALL_FILES" | grep -vE '(_test\.|\.test\.|\.spec\.|/tests?/|/__tests__/)' || true)

echo "$APP_FILES"
echo "--- test files ---"
echo "$TEST_FILES"
