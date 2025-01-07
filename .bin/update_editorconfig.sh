#!/usr/bin/env bash
set -e

if ! test -f build.gradle.kts; then
  echo "Not a gradle project."
  exit 0
fi

echo "Updating ..."
if [[ ! -e "/.editorconfig" ]]; then
  echo "No file existed, creating one ..."
  echo "" > ".editorconfig"
  echo "created editorconfig"
fi

cat ../.editorconfig > ".editorconfig"

echo "Copied editorconfig and committing changes ..."
find . -name ".editorconfig" -print0 | xargs -0 git add

COMMIT_MESSAGE="Oppdatere .editorconfig"
git commit -m"$COMMIT_MESSAGE"
