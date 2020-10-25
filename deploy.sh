#!/bin/sh

# Verbose Output
set -v

printf "\033[0;32mDeploying updates to GitHub...\033[0m\n"

# Build the project:
hugo -t hugo-split-theme # if using a theme, replace with `hugo -t hugo-split-theme`

# Go To Public folder:
cd public

# Add changes to site repo:
git add .

# Commit changes to site repo:
msg="rebuilding site $(date)"
if [ -n "$*" ]; then
	msg="$*"
fi
git commit -m "$msg"

# Return to the project root:
cd ../

# Add changes to the project repo:
git add .

# Commit changes to the project repo:
git commit -m "$msg"

# Push source, build repos *and* the public submodule to Github together.
git push -u origin master --recurse-submodules=on-demand
