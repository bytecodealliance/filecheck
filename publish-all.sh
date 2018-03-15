#!/bin/bash
set -euo pipefail
cd $(dirname "$0")
topdir="$(pwd)"

version="0.2.1"

# Update all of the Cargo.toml files.
#
echo "Updating crate versions to $version"
# Update the version number of this crate to $version.
sed -i.bk -e "s/^version = .*/version = \"$version\"/" Cargo.toml

# Update our local Cargo.lock (not checked in).
cargo update
./test-all.sh

# Commands needed to publish.
#
# Note that libraries need to be published in topological order.

echo git commit -a -m "\"Bump version to $version"\"
echo git push
echo cargo publish --manifest-path Cargo.toml
echo
echo Then, go to https://github.com/Cretonne/filecheck/releases/ and define a new release.
