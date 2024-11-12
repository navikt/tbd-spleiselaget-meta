#!/usr/bin/env bash

cat .meta | jq -r '.projects | keys[]' | while read -r project; do
  if ! grep -q "includeBuild \"$project\"" settings.gradle; then
    echo "includeBuild \"$project\"" >> settings.gradle
  fi
done