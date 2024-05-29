#!/bin/bash

# a template file for generating scripted build system for c-like languages

if [[ ! -d target ]]; then
    mkdir target
fi

./compile_step &&
    ./link_step &&
    echo "Build process completed!"
