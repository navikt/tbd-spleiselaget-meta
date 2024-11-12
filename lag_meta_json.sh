#!/usr/bin/env sh

gh api /teams/$(gh api /orgs/navikt/teams/tbd | jq -r '.id')/repos --paginate \
  | jq -r '{projects: [.[] | select(.archived == false and (.topics | index("speilvendt") | not) and .name != "helsearbeidsgiver-bro-sykepenger" and .name != "afp" and .name != "tbd-spleiselaget-meta" and .name != "tbd-meta" and .name != "vault-iac") | {"meta-\(.name)":.clone_url}] | add}' \
  | tee > .meta

