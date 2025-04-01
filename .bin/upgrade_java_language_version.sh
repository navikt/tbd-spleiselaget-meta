#!/usr/bin/env bash
set -e

if [ -z ${JAVA_LANGUAGE_VERSION+x} ]; then
  echo "JAVA_LANGUAGE_VERSION must be set";
  exit 1
fi

echo "Upgrading ..."
find . -name "build.gradle.kts" -exec sed -i '' 's/languageVersion.set(JavaLanguageVersion.of([^)]*))/languageVersion.set(JavaLanguageVersion.of("'$JAVA_LANGUAGE_VERSION'"))/g' {} +
echo "Building post-upgrade ..."
./gradlew -q --warning-mode=all build
echo "Committing changes ..."
find . -name "build.gradle.kts" -print0 | xargs -0 git add

COMMIT_MESSAGE="Bump JDK Toolchain -> $JAVA_LANGUAGE_VERSION"
git commit -m"$COMMIT_MESSAGE"
