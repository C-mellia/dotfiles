#!/bin/bash

which pyinstaller &> /dev/null && { echo "pyinstaller not installed" >&2; exit 1; }

cmd() { echo "$*" && "$@"; }

build_target() {
    declare TARGET ENTRY

    cmd pyinstaller\
        -F\
        -n "$TARGET"\
        --distpath "$distpath"\
        --workpath "$build"\
        -p ./src:./\
        --log-level ERROR\
        --optimize 2\
        -s\
        "$ENTRY" || {
        echo "Failed to build target $TARGET" >&2; exit 1
    }
}

[[ -z $distpath ]] && distpath=./
[[ -z $build ]] && build=./build

[[ -d $distpath ]] || mkdir -p "$distpath"
[[ -d $build ]] || mkdir -p "$build"

TARGET=main ENTRY=src/main.py build_target

echo "Finished building the project"; exit 0
