#!/bin/bash

[[ -d ./target/ ]] || mkdir target/
./.compile && ./.link && echo "Build process completed!"
