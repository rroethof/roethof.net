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

#############################
# Git squash naar 1 commit
#############################

# Zorg dat we op master zitten
git checkout master

# Optioneel: stash onbewerkte wijzigingen
git stash push -m "Auto-stash before squash"

# Squash alles naar 1 commit
git reset $(git commit-tree HEAD^{tree} -m "Alles samengevoegd in 1 commit")

# Force push naar remote
git push origin master --force

# Haal stash terug als die er was
git stash pop || true

echo "Alle commits zijn samengevoegd tot 1 commit en gepusht naar master."