#!/bin/bash

tmux has-session -t="$HOME" /dev/null 2>&1 || tmux new-session -ds "$HOME" -c "$HOME"
tmux a
