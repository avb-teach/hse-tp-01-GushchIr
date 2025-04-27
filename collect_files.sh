#!/bin/bash

input_dir="$1"
output_dir="$2"
max_depth=""

give_name() {
    local way_to_file = "$1"
    local file_name = $(basename "$way_to_file")
    local name = "${file_name%.*}"
    local extension = "${file_name##*.}"
    local c = 1
    local new_name = "$file_name"
    while [ -e "$output_dir/$new_name" ]; do
        new_name="${name}_${c}.${extension}"
        c = $((c + 1))
    done

    echo "$new_name"
}

copy_files() {
    local src="$1"
    
    for item in "$src"/*; do
        if [ -f "$item" ]; then
            name = $(give_name "$item")
            cp "$item" "$output_dir/"
        elif [ -d "$item" ]; then
            copy_files "$item"
        fi
    done
}

copy_files "$input_dir"