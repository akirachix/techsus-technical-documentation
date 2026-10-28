#!/usr/bin/env bash
set -eu

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

printf "Techsus documentation evidence manifest\n"
printf "Repository: %s\n\n" "$ROOT"

for path in README.md mkdocs.yml requirements.txt docs; do
	if [ -e "$path" ]; then
		printf "FOUND %s\n" "$path"
	else
		printf "MISSING %s\n" "$path"
	fi
done

printf "\nDocumentation pages:\n"
find docs -maxdepth 1 -type f -name '*.md' | sort

printf "\nAutomation files:\n"
find . -maxdepth 3 \( -path './.git' -o -path './site' \) -prune -o -type f \( -name '*.sh' -o -name '*.yml' -o -name '*.yaml' \) -print | sort
