#!/bin/bash

prefix=$HOME/.local
target=$(basename "$PWD")
binary_file=main
type=bin

cmd() { echo "$*"; "$@"; }

[[ -x $binary_file ]] || {
    echo "Executable '$binary_file' not found" || exit 1
}
cmd cp "$binary_file" "$prefix/$type/$target"
