Meta for Team SAS
=====================

## Noen forutsetninger

Du må ha installert:
- jq (`brew install jq`)
- gh (`brew install gh`)
- (og sikkert flere ting)

## en optional forutsetning:

`brew install just`

.. eller hvordan du ellers har lyst til å installere `just` på akkurat _din_ maskin.


## Komme i gang

[meta](https://github.com/mateodelnorte/meta) brukes til å sette opp
repositories for alle repoene.

Enn så lenge må du sørge for å ha `pnpm` installert (`brew install node`).

```
pnpm install meta -g --no-save
```

Merk! meta foran vanlig clone-kommando:
```
meta git clone git@github.com:navikt/helse-sas-meta.git
```

Du kloner altså _ikke_ `helse-sas-meta` med vanlig git, du må gå via `meta`. 
Kommandoen over vil opprette en mappe kalt `helse-sas-meta`, med alle prosjekter listet i `.meta` inni seg.

Nå kan git brukes som normalt for hvert repo.

Se [meta](https://github.com/mateodelnorte/meta) for flere kommandoer.

Dersom du nå åpner `build.gradle.kts` med `Open` (som Project) i IntelliJ så får du alle komponentene inn i ett IntelliJ-oppsett.

## Legge til nye repos?

Det enkleste er å kjøre `./oppdater_metaoppsett.sh` ettersom den vil selv innhente alle repos hvor `tbd` er owner,
og dytte resultatet inn i `.meta` (den ekskluderer også noen repoer Team SAS ikke eier - se [oppdater_metaoppsett.sh](oppdater_metaoppsett.sh)).

Så kjører du `meta git update` for å clone nye repositories. Om det er et gradle-prosjekt må den også legges inn i `settings.gradle`

## Hvordan .... ?

Alt nedenfor som refererer til `make` kan potenselt bli erstattet av `just`, men med kulere syntax.

### Finne ut av hva jeg kan gjøre med `just`

`just --list`

og så besøke https://just.systems/man/en/ om du har lyst til å skjønne `just`

### Oppgradere Gradle wrapper

```
make upgrade-gradle
```
Kommandoen vil gå gjennom alle prosjektene og bumpe gradle til siste versjon, bygge/teste koden, og commit'e til slutt.
Du kan bekrefte commits etterpå ved å kjøre:
```
make list-local-commits
```

For å shippe det så kjører du
```
meta git push
```
### Oppgradere Kotlin JVM

```
KOTLIN_VERSION=2.0.21 make upgrade-kotlin-jvm
```
Kommandoen vil gå gjennom alle prosjektene og bumpe kotlin jvm til siste versjon, bygge/teste koden, og commit'e til slutt.
Du kan bekrefte commits etterpå ved å kjøre:
```
make list-local-commits
```

For å shippe det så kjører du
```
meta git push
```

_Forutsetninger_: koden forutsetter at det finnes en `build.gradle.kts`-fil med en slik linje:
```kotlin
kotlin("jvm") version "en_versjon_her"
```

### Oppgradere Java language version

```
JAVA_LANGUAGE_VERSION=22 make upgrade-java-language-version
```
Kommandoen vil gå gjennom alle prosjektene og bumpe java language version til siste versjon, bygge/teste koden, og commit'e til slutt.
Du kan bekrefte commits etterpå ved å kjøre:
```
make list-local-commits
```

For å shippe det så kjører du
```
meta git push
```

_Forutsetning_: koden forutsetter at det finnes en `build.gradle.kts`-fil med en slik linje:
```kotlin
languageVersion.set(JavaLanguageVersion.of("en_versjon_her"))
```
for eksempel noe sånn:
```kotlin
kotlin {
    jvmToolchain {
        languageVersion.set(JavaLanguageVersion.of("21"))
    }
}
```

### Oppdatere linting i alle prosjekt

Gjør endringer i .editorconfig på root.
Kjør kommandoen
```
make upgrade-editorconfig
```

Kommandoen vil gå gjennom alle prosjektene og endre til nyeste versjon, og commit'e til slutt.
Du kan bekrefte commits etterpå ved å kjøre:

```
make list-local-commits
```

## Henvendelser
Spørsmål knyttet til koden eller prosjektet kan stilles som issues her på GitHub.

### For NAV-ansatte
Interne henvendelser kan sendes via Slack i kanalen ![#team-sas-værsågod](https://nav-it.slack.com/archives/C019637N90X).
