#!/bin/bash

step_error() {
    echo $* && exit 1
}

step_exec() {
    echo $1 && eval $1 || step_error $2
}


export srcs='main'
export -f step_error step_exec

[[ -d ./target/ ]] || mkdir target/

./.compile && ./.link && echo "Build process completed!"
