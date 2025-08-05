#!/usr/bin/env bash

if ! test -f build.gradle.kts; then
  echo "Not a gradle project."
  exit 0

fi

echo "Upgrading ..."
./gradlew wrapper --gradle-version=latest --distribution-type bin >/dev/null 2>&1
./gradlew wrapper >/dev/null 2>&1

echo "Building post-upgrade ..."
output=$(./gradlew -q --warning-mode=all build 2>&1)
exit_code=$?
if [ $exit_code -ne 0 ]; then
  echo "$output"
  exit $exit_code
fi

echo "Committing changes ..."
git add gradle gradlew.bat gradlew

COMMIT_MESSAGE="Bump Gradle wrapper til latest"
git commit -m"$COMMIT_MESSAGE"

if [ $? -ne 0 ]; then
  echo "No changes to commit."
else
  echo "Changes committed successfully."
fi