#!/usr/bin/env bash
set -e

if ! test -f build.gradle.kts; then
  echo "Not a gradle project."
  exit 0

fi

echo "Upgrading ..."
./gradlew wrapper --gradle-version=latest --distribution-type bin
./gradlew wrapper
echo "Building post-upgrade ..."
./gradlew -q --warning-mode=all build
echo "Committing changes ..."
git add gradle gradlew.bat gradlew

COMMIT_MESSAGE="Bump Gradle wrapper til latest"
git commit -m"$COMMIT_MESSAGE"


