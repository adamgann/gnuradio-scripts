#!/bin/bash
#
# Move a file from one directory to another 




# Constants 
path_base="$HOME/src"
c_lib_post="_impl.cc"
h_lib_post="_impl.h"
h_head_post=".h"
grc_pre="_"
grc_post=".xml"

clear
echo "Copy GNURadio Files"
echo "This script has no protection for overwriting files."
echo "Use at your own risk."
echo -e "\nFirst run modtool in the destination directory"
echo "Enter the source and destination directories without 'gr-'"
echo -e "Enter the file prefix created using modtool\n"

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

if promptyn "Moving files with '$file_pref' from '$source_dir' to '$dest_dir'. Correct?"; then
    echo -e "Copying...\n"
else
    exit
fi

source_path="$path_base/gr-$source_dir"
dest_path="$path_base/gr-$dest_dir"


source_dir_upper=${source_dir^^}
dest_dir_upper=${dest_dir^^}


# Copy the three files over 
cp "$source_path/lib/$file_pref$c_lib_post" "$dest_path/lib"
cp "$source_path/lib/$file_pref$h_lib_post" "$dest_path/lib"
cp "$source_path/include/$source_dir/$file_pref$h_head_post" "$dest_path/include/$dest_dir"
cp "$source_path/grc/$source_dir$grc_pre$file_pref$grc_post" "$dest_path/grc"

mv "$dest_path/grc/$source_dir$grc_pre$file_pref$grc_post" "$dest_path/grc/$dest_dir$grc_pre$file_pref$grc_post"


# Start Replacing Text Within The Files
sed -i "s/$source_dir/$dest_dir/I" "$dest_path/lib/$file_pref$c_lib_post"
sed -i "s/$source_dir_upper/$dest_dir_upper/I" "$dest_path/lib/$file_pref$c_lib_post"

sed -i "s/$source_dir/$dest_dir/I" "$dest_path/lib/$file_pref$h_lib_post"
sed -i "s/$source_dir_upper/$dest_dir_upper/I" "$dest_path/lib/$file_pref$h_lib_post"

#sed -i "s/$source_dir/$dest_dir/I" "$dest_path/include/$dest_dir/$file_pref$h_head_post"
#sed -i "s/CDMARX4/CDMARX5/I" "$dest_path/include/$dest_dir/$file_pref$h_head_post"
perl -i.tmp -pe "s/$source_dir/$dest_dir/" "$dest_path/include/$dest_dir/$file_pref$h_head_post"
perl -i.tmp -pe "s/$source_dir_upper/$dest_dir_upper/" "$dest_path/include/$dest_dir/$file_pref$h_head_post"

sed -i "s/$source_dir/$dest_dir/I" "$dest_path/grc/$dest_dir$grc_pre$file_pref$grc_post"
sed -i "s/$source_dir_upper/$dest_dir_upper/I" "$dest_path/grc/$dest_dir$grc_pre$file_pref$grc_post"

echo "Complete."











