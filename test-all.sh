#!/bin/bash
set -euo pipefail

# This is the top-level test script:
#
# - Make a debug build.
# - Make a release build.
# - Run unit tests for all Rust crates
# - Build API documentation.
#
# All tests run by this script should be passing at all times.

# Repository top-level directory.
cd $(dirname "$0")
topdir=$(pwd)

function banner() {
    echo "======  $@  ======"
}

# Run rustfmt if we have it.
if $topdir/check-rustfmt.sh; then
    banner "Rust formatting"
    $topdir/format-all.sh --write-mode=diff
fi

cd "$topdir"

# Make sure the code builds in debug mode.
banner "Rust debug build"
cargo build

# Make sure the code builds in release mode, and run the unit tests. We run
# these in release mode for speed, but note that the top-level Cargo.toml file
# does enable debug assertions in release builds.
banner "Rust release build and unit tests"
cargo test --all --release

# Make sure the documentation builds.
banner "Rust documentation: $topdir/target/doc/filecheck/index.html"
cargo doc

banner "OK"
