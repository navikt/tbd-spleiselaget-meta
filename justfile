# installer just med `brew install just`

meta_project := file_name(justfile_directory())

default:
    @just --list

pull:
    @meta exec "git pull --all --rebase --autostash" --parallel --exclude "{{meta_project}}"

push:
    @meta exec "git push" --parallel

# kjør git checkout . på alle repo
regret:
    @meta exec "git checkout ." --parallel

# slett alle filer som git ikke vet om
clean:
    @meta exec "git clean -f" --parallel

# viser frem lokale commits
list-commits:
    @meta exec "git log --oneline @{u}..HEAD | cat" --exclude "{{meta_project}}"

# vis lokale commits og bestem om du vil pushe
prepush-review:
    @meta exec 'output=$(git log --oneline origin/HEAD..HEAD) ; [ -n "$output" ] && (git show --oneline origin/HEAD..HEAD | cat && echo "Pushe? (y/N)" && read a && [ "$a" = "y" ] && git push) || true' --exclude "{{meta_project}}"

# oppdaterer alle til siste gradle-versjon
upgrade_gradle:
    @meta exec "{{ justfile_directory() }}/.bin/upgrade_gradle.sh" --exclude "{{meta_project}}"

# "versjon" er den nye kotlin-versjonen alle repoene skal bygges på
upgrade_kotlin versjon:
    @KOTLIN_VERSION={{ versjon }} meta exec "{{ justfile_directory() }}/.bin/upgrade_kotlin_jvm.sh" --exclude "{{meta_project}}"

# "versjon" er den nye java language version alle repoene skal bygges på
upgrade-java-language-version versjon:
    @JAVA_LANGUAGE_VERSION={{ versjon }} meta exec "{{ justfile_directory() }}/.bin/upgrade_java_language_version.sh" --exclude "{{meta_project}}"

# oppdater editorconfig i alle prosjekter
upgrade-editorconfig:
    @meta exec "{{ justfile_directory() }}/.bin/update_editorconfig.sh" --exclude "{{meta_project}}"

# viser short description av alle repoer
describe:
    @meta exec "gh repo view --json description -q '.[\"description\"]'" --exclude "{{meta_project}}"

# bygg alt på nytt
bygg-alt-pa-nytt:
    @meta exec "{{ justfile_directory() }}/.bin/bygg_alt_på_nytt.sh" --exclude "{{meta_project}}"

# pull alle repos og vis nye commits siden sist
pull-and-describe:
    @{{ justfile_directory() }}/pull-and-describe.sh
