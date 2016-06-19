#!/bin/bash

set -eux

if [[ ! ( "${TRAVIS_BRANCH}" = 'master' && "${TRAVIS_PULL_REQUEST}" = 'false' ) ]]; then
   exit 0
fi

cd built-site

git init
git config user.name "Travis-CI"
git config user.email "builder@travis"

git add .
git commit -m "Deployed to Github Pages"

set +x # Never print the token!
git push --force --quiet "https://${GH_TOKEN}@github.com/${TRAVIS_REPO_SLUG}" master:gh-pages
