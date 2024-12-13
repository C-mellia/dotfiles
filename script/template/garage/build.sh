#!/bin/bash

export srcs=$(
while read -r file; do
    basename "${file%.c}" | /bin/grep -vE '^\.'
done <<< "$(find src/ -type f | /bin/grep -E '\.c$')"
)

[[ -d ./target/ ]] || mkdir target/

./.compile && ./.link && echo "Build process completed!"
