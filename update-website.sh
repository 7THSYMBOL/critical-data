#!/bin/sh
echo "Building server"
hugo

echo "Updating gh-pages branch"
git -C public add --all
git -C public commit -m "publishing to gh-pages"

echo "Pushing gh-pages branch"
if [ -n "$GITHUB_API_TOKEN" ]; then
    # CI deployment
    git -C public push -f https://fhunleth:$GITHUB_API_TOKEN@github.com/fhunleth/embedded-elixir gh-pages:gh-pages 2>&1 | \
        sed s/$GITHUB_API_TOKEN/HIDDEN/g
else
    # Manual deployment
    git -C public push -f git@github.com:fhunleth/embedded-elixir.git gh-pages
fi


git -C public push -f git@github.com:fhunleth/embedded-elixir.git gh-pages
