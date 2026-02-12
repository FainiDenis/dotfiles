#!/usr/bin/env bash

set -e

DOTFILES_ROOT="$(cd "$(dirname "$0")/.." && pwd -P)"
SRC="$DOTFILES_ROOT/hazelnut/config.toml"
DST_DIR="$HOME/.config/hazelnut"
DST="$DST_DIR/config.toml"

mkdir -p "$DST_DIR"
ln -sfn "$SRC" "$DST"
echo "› linked $DST -> $SRC"
