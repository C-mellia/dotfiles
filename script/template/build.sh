#!/bin/bash

# template of the scripted build procedure of c-like languages

if [[ ! -d target ]]; then
    mkdir target
fi

./compile_step && ./link_step && echo "Build process completed!"
