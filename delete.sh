#!/bin/bash

REPO_OWNER="rroethof"
REPO_NAME="roethof.net"

# Haal lijst van alle workflow runs op (max 100 per keer)
RUN_IDS=$(gh run list --limit 100 --json databaseId -q '.[].databaseId')

# Loop door alle runs en delete via API
for run_id in $RUN_IDS; do
    echo "Verwijder run $run_id"
    curl -s -X DELETE \
        -H "Authorization: token $(gh auth token)" \
        -H "Accept: application/vnd.github+json" \
        "https://api.github.com/repos/$REPO_OWNER/$REPO_NAME/actions/runs/$run_id"
done

echo "Klaar! Alle runs zijn verwijderd."
