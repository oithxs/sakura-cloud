#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)
cd $SCRIPT_DIR

TEMA_MEMBER=$(gh api \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  /orgs/$GITHUB_ORG/teams/$TEAM_SLUG/members | \
  jq -r .[].login)

echo -n "" > ../authorized_keys

for member in $TEMA_MEMBER; do
  echo "# $member" >> ../authorized_keys
  curl -s "https://github.com/$member.keys" >> ../authorized_keys
  echo "$member is added to authorized_keys"
done
