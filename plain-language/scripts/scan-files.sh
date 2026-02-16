#!/bin/sh
# scan-files.sh — Find reviewable text files in a project directory.
# Usage: scan-files.sh [directory]
# Defaults to current directory if no argument given.

set -e

TARGET_DIR="${1:-.}"

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
    -name '*.txt' -o \
    -name '*.rst' -o \
    -name '*.adoc' \
  \) -print | sort
