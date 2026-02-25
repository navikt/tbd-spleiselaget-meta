# installer just med `brew install just`
# note to self (og kanskje andre?): just skal erstatte _make_, ikke _meta_
# note2 to self: finn ut hvorfor folk synes just er bedre enn make -- ser ikke ut som en kjempeforskjell enda

pull:
    @meta exec "git pull --all --rebase --autostash" --parallel

push:
    @meta exec "git push" --parallel

# kjør git checkout . på alle repo
regret:
    @meta exec "git checkout ." --parallel

# viser frem lokale commits
list-commit:
    @meta exec "git log --oneline @{u}..HEAD | cat"

# oppdaterer alle til siste gradle-versjon
upgrade_gradle:
    @meta exec "{{ justfile_directory() }}/.bin/upgrade_gradle.sh" --parallel

# "versjon" er den nye kotlin-versjonen alle repoene skal bygges på
upgrade_kotlin versjon:
    @KOTLIN_VERSION={{ versjon }} meta exec "{{ justfile_directory() }}/.bin/upgrade_kotlin_jvm.sh"

# viser short description av alle repoer
describe:
    @meta exec "gh repo view --json description -q '.[\"description\"]'"
