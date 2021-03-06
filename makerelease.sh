#!/bin/bash
# Run this script after committing an updated info.json to automatically tag the update and prepare a zip of it.

# Get mod name and version from info.json
# https://stedolan.github.io/jq/
modname=`cat info.json|jq -r .name`
modver=`cat info.json|jq -r .version`
gitbranch=`git rev-parse --abbrev-ref HEAD`

# Switch to master branch
git checkout master

# Merge in develop branch
git merge --no-ff develop

# Create git tag for this version
git tag "v$modver"

# Prepare zip for Factorio native use and mod portal
git archive --prefix "${modname}_$modver/" -o "/Users/james/Desktop/tmp/${modname}_$modver.zip" HEAD

# Push tag to git
git push origin "v$modver"

# Switch back to original branch
git checkout $gitbranch
