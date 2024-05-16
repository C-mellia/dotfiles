#!/bin/bash

# template of the scripted build procedure of c-like languages

# select which compiler to use
COMPILER=gcc
# send flags to compiler
COMPILER_FLAG='-Wall -Wextra -std=gnu11'
# libraries to link or send flags to linker, if link step is necessary
LINK_FLAG=''
# select files to compile, separate file names with space
SRC_FILES='main'
# select files to compile and archive as separate shared libraries
SHARED_LIBS=''
# source directory of c-files to be searched
SRC='src'

function _compile {
    echo "$COMPILER -c $1 -o $2 -static $COMPILER_FLAG"
    $COMPILER -c $1 -o $2 -static $COMPILER_FLAG
}

function _compile_shared {
	echo "$COMPILER -shared $1 -o $2 $COMPILER_FLAG"
	$COMPILER -shared $1 -o $2 $COMPILER_FLAG
}

function _link_objects {
    targets=""
    for fname in $*; do
        targets+="./target/$fname.o "
    done
    echo "$COMPILER $targets -o main $LINK_FLAG"
    $COMPILER $targets -o main $LINK_FLAG
}

if [[ ! -d target ]]; then
    mkdir target
fi

for fname in $SRC_FILES; do
    if [[ ! -f $SRC/$fname.c ]]; then
        echo "WARNING: File $fname not found in dir $SRC, skipping..."
        continue
    fi
    _compile $SRC/$fname.c target/$fname.o
    if [[ ! $? -eq 0 ]]; then
        echo "ERROR: Failed to build $fname, exiting..."
        exit 1
    fi
done

_link_objects $SRC_FILES
if [[ ! $? -eq 0 ]]; then
    echo "ERROR: Failed to link"
    exit 1
fi

for fname in $SHARED_LIBS; do
	if [[ ! -f $SRC/$fname.c ]]; then
		echo "WARNING: File $fname not found in dir $SRC, skipping..."
		continue
	fi
	_compile_shared $SRC/$fname.c lib$fname.so
	if [[ ! $? -eq 0 ]]; then
		echo "ERROR: Failed to build $fname, exiting..."
		exit 1
	fi
done

echo "Build process completed!"
