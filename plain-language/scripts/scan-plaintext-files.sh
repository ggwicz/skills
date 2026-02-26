#!/usr/bin/env bash
# scan-plaintext-files.sh — Finds reviewable text files in a directory.
# Usage: scan-plaintext-files.sh <directory>

set -e

if [ -z "$1" ]; then
  echo "Usage: scan-plaintext-files.sh <project-directory>" >&2
  echo "Error: project directory argument is required." >&2
  exit 1
fi

TARGET_DIR="$1"

# Find plaintext files, excluding common noise directories.
find "$TARGET_DIR" \
  -type d \( \
    -name '.*' -o \
    -name node_modules -o \
    -name vendor -o \
    -name __pycache__ -o \
    -name dist -o \
    -name build -o \
    -name coverage -o \
    -name venv -o \
    -name target \
  \) -prune -o \
  -type f \( \
    -name '*.md' -o \
    -name '*.mdx' -o \
    -name '*.markdown' -o \
    -name '*.txt' -o \
    -name '*.rtf' -o \
    -name '*.rst' -o \
    -name '*.adoc' -o \
    -name '*.org' -o \
    -name '*.wiki' \
  \) -print | sort
