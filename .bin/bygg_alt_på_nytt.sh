#!/usr/bin/env bash
set -e

NOW=$(date +"%Y-%m-%dT%H:%M:%S")
NEW_LINE="ARG BYGD_PA_NY='$NOW'"

find . -type f -name 'Dockerfile*' | while read -r file; do
  if grep -q '^ARG BYGD_PA_NY=' "$file"; then
    # Erstatt eksisterende linje
    sed -i '' "s|^ARG BYGD_PA_NY=.*|$NEW_LINE|" "$file"
  else
    # Legg til med newline før
    printf "\n%s\n" "$NEW_LINE" >> "$file"
  fi
done
