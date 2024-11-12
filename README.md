Meta for spleiselaget
=====================

## Noen forutsetninger

Du må ha installert:
- jq (`brew install jq`)
- gh (`brew install gh`)
- (og sikkert flere ting)

## Komme i gang

[meta](https://github.com/mateodelnorte/meta) brukes til å sette opp
repositories for alle repoene.

Enn så lenge må du sørge for å ha `npm` installert (`brew install node`).

```
npm install meta -g --no-save
```

Merk! meta foran vanlig clone-kommando:
```
meta git clone https://github.com/navikt/tbd-spleiselaget-meta.git
```

Du kloner altså _ikke_ `tbd-spleiselaget-meta` med vanlig git, du må gå via `meta`. 
Kommandoen over vil opprette en mappe kalt `tbd-spleiselaget-meta`, med alle prosjekter listet i `.meta` inni seg.

Nå kan git brukes som normalt for hvert repo.

Se [meta](https://github.com/mateodelnorte/meta) for flere kommandoer.

Dersom du nå åpner `build.gradle.kts` med `Open` (som Project) i IntelliJ så får du alle komponentene inn i ett IntelliJ-oppsett.

## Legge til nye repos?

Det enkleste er å kjøre `./lag_meta_json.sh` ettersom den vil selv innhente alle repos hvor `tbd` er owner,
og dytte resultatet inn i `.meta` (den ekskluderer også ting som er tagget med `speilvendt`).

## Henvendelser
Spørsmål knyttet til koden eller prosjektet kan stilles som issues her på GitHub.

### For NAV-ansatte
Interne henvendelser kan sendes via Slack i kanalen ![#team-bømlo-værsågod](https://nav-it.slack.com/archives/C019637N90X).
