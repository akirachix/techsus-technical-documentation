#!/usr/bin/env bash
set -eu

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

printf "Running MkDocs build validation...\n"
mkdocs build

printf "\nBuild completed successfully.\n"
printf "Documentation output directory: %s/site\n" "$ROOT"
