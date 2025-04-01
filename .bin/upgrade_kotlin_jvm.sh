#!/usr/bin/env bash
set -e

if [ -z ${KOTLIN_VERSION+x} ]; then
  echo "KOTLIN_VERSION must be set";
  exit 1
fi

echo "Upgrading ..."
find . -name "build.gradle.kts" -exec sed -i '' 's/kotlin("jvm") version "[^"]*"/kotlin("jvm") version "'$KOTLIN_VERSION'"/g' {} +
echo "Building post-upgrade ..."
./gradlew -q --warning-mode=all build
echo "Committing changes ..."
find . -name "build.gradle.kts" -print0 | xargs -0 git add

COMMIT_MESSAGE="Bump Kotlin JVM -> $KOTLIN_VERSION"
git commit -m"$COMMIT_MESSAGE"
