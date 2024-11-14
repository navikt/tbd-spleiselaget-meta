.PHONY: $(shell sed -n -e '/^$$/ { n ; /^[^ .\#][^ ]*:/ { s/:.*$$// ; p ; } ; }' $(MAKEFILE_LIST))

root_dir := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
meta_project := $(notdir $(patsubst %/,%,$(dir $(root_dir))))

help:
	@echo "$$(grep -hE '^\S+:.*##' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' -e 's/^\(.\+\):\(.*\)/\\x1b[36m\1\\x1b[m:\2/' | column -c2 -t -s :)"

pull:
	@meta exec "git pull --all --rebase --autostash" --parallel --exclude "$(meta_project)"

build:
	@meta exec 'test -f ./gradlew && ./gradlew -q build || true' --exclude "$(meta_project)"

list-local-commits: ## shows local, unpushed, commits
	@meta exec "git log --oneline origin/HEAD..HEAD | cat" --exclude "$(meta_project)"

prepush-review: ## let's you look at local commits across all projects and decide if you want to push
	@meta exec 'output=$$(git log --oneline origin/HEAD..HEAD) ; [ -n "$$output" ] && (git show --oneline origin/HEAD..HEAD | cat && echo "Pushe? (y/N)" && read a && [ "$$a" = "y" ] && git push) || true' --exclude "$(meta_project)"

upgrade-gradle: ## Upgrade gradle in all projects - usage make upgrade-gradle
	@meta exec "$(root_dir).bin/upgrade_gradle.sh" --exclude "$(meta_project)"

upgrade-kotlin-jvm: ## Upgrade kotlin in all projects - usage KOTLIN_VERSION=x.x.x make upgrade-kotlin-jvm
	@meta exec "$(root_dir).bin/upgrade_kotlin_jvm.sh" --exclude "$(meta_project)"

upgrade-java-language-version: ## Upgrade langauge version in all projects - usage JAVA_LANGUAGE_VERSION=x.x.x make upgrade-java-language-version
	@meta exec "$(root_dir).bin/upgrade_java_language_version.sh" --exclude "$(meta_project)"
