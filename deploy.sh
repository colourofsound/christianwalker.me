#!/bin/sh

# If a command fails then the deploy stops
set -e -x

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project.
hugo -t hugo-split-theme # if using a theme, replace with `hugo -t hugo-split-theme`

# Go To Public folder
cd public

# Add changes to git.
git add .

# Commit changes.
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# 5. Return to the project root.
cd ../

# 6-7.
git add .
git commit -m "$msg"

# Push source, build repos *and* the public submodule to Github together.
git push -u origin master --recurse-submodules=on-demand
