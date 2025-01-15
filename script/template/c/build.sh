#!/bin/bash

[[ -d ./target/ ]] || mkdir target/

export srcs=$(
while read -r file; do
    basename "$file" .c | /bin/grep -vE '^\.+'
done <<< "$(find src/ -type f | /bin/grep -E '\.c$')"
)

./.compile && ./.link && echo "Build process completed!"
