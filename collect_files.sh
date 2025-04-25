#!/bin/bash

input_dir="$1"
output_dir="$2"
max_depth=""

copy_files() {
    local src="$1"
    
    for item in "$src"/*; do
        if [ -f "$item" ]; then
            cp "$item" "$output_dir/"
        elif [ -d "$item" ]; then
            copy_files "$item"
        fi
    done
}

copy_files "$input_dir"