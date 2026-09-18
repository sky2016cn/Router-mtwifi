#!/bin/bash
set -e -o pipefail

WORKSPACE_ROOT="${GITHUB_WORKSPACE:-$(pwd)}"
GOLANG126_SRC_DIR="$WORKSPACE_ROOT/scripts/6.6/golang1.27"
GOLANG126_FEED_DIR="feeds/packages/lang/golang1.27"
rm -rf "$GOLANG126_FEED_DIR"
mkdir -p "$GOLANG126_FEED_DIR"
cp -rf "$GOLANG126_SRC_DIR/." "$GOLANG126_FEED_DIR/"
./scripts/feeds update -f packages
./scripts/feeds install golang1.27

# passwall daed use golang1.27/host
find package/dae package/passwall-packages -name "Makefile" -type f -exec sed -i \
  -e 's|\<golang/golang-package.mk\>|golang1.27/golang-package.mk|g' \
  -e 's|\<golang/host\>|golang1.27/host|g' {} +
