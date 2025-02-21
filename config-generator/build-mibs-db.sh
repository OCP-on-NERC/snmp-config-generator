#!/bin/bash
#
# This script rebuilds the `mibs/` directory from upstream sources.

git_clone_or_update() {
  local repo="$1"
  local dir="$2"

  if [[ -d "$dir" ]]; then
    echo "Updating $dir..."
    git -C "$dir" pull
  else
    echo "Cloning $dir..."
    git clone "$repo" "$dir"
  fi
}

mkdir -p src

# Get remote MIB collections
git_clone_or_update https://github.com/cisco/cisco-mibs src/cisco
git_clone_or_update https://github.com/librenms/librenms src/librenms
git_clone_or_update https://github.com/kcsinclair/mibs.git src/kcsinclair

echo "Updating mibs directory"
mkdir -p mibs
xargs -IMIB cp MIB mibs/ < miblist.txt
