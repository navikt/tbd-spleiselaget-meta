#!/usr/bin/env sh

gh api /teams/$(gh api /orgs/navikt/teams/tbd | jq -r '.id')/repos --paginate \
  | jq --sort-keys -r '{projects: [.[] | select(.archived == false and .name != "helse-sas-meta" and .name != "helsearbeidsgiver-bro-sykepenger" and .name != "vault-iac") | {"meta-\(.name)":.clone_url}] | add}' \
  | tee > .meta

