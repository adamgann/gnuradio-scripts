#!/bin/bash
#
# Move a file from one directory to another 
# This file is different



# Constants 
path_base="$HOME/src"


promptyn () {
    while true; do
        read -p "$1 " yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}



echo -n "Source Directory: "
read source_dir

echo -n "Destination Directory: "
read dest_dir

echo -n "File Prefix: "
read file_pref

source_path="$path_base/$source_dir"
dest_path="$path_base/$dest_dir"


cp "$path_base/scripts/move_file.sh" "$path_base/scripts/test"

exit


if promptyn "Moving files with '$file_pref' from '$source_dir' to '$dest_dir'. Correct?"; then
    echo "yes"
else
    echo "no"
fi








