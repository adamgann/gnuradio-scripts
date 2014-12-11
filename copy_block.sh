#!/bin/bash
#
# Make a copy of a block in the same directory with a new index.
# ver 1.0
# Adam Gannon


# Constants 
path_base="$HOME/src"
c_lib_post="_impl.cc"
h_lib_post="_impl.h"
h_head_post=".h"
grc_pre="_"
grc_post=".xml"

curr_dir=${pwd}


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

clear


echo -e "Copy GNU Radio Block\n"
echo "This script has no protection against overwriting files."
echo -e "Use at your own risk.\n"


echo -n "Enter the mod name without the 'gr-' prefix: "
read mod_name

echo -n "Enter the block name: "
read block_name

echo -n "Enter the index for the new block: "
read block_index


if promptyn "In gr-$mod_name, I am copying the contents of $block_name to $block_name$block_index. Correct?"; then
  echo -e "Copying...\n"
else
  echo -e "Stopping and exiting...\n"
  exit
fi
 


## Set Some Parameters
mod_base="$path_base/gr-$mod_name"
block_name_upper=${block_name^^}


## Create new block with modtool
cd $mod_base

yes n | gr_modtool add -t general -l c++ -N $block_name$block_index --argument-list=""

echo "New block created"


## Copy Files


# Copy impl.cc
cp "$mod_base/lib/$block_name$c_lib_post" "$mod_base/lib/$block_name$block_index$c_lib_post"

# Copy impl.h
cp "$mod_base/lib/$block_name$h_lib_post" "$mod_base/lib/$block_name$block_index$h_lib_post"

# Copy .h
cp "$mod_base/include/$mod_name/$block_name$h_head_post" "$mod_base/include/$mod_name/$block_name$block_index$h_head_post"

# Copy .xml
cp "$mod_base/grc/$mod_name$grc_pre$block_name.xml" "$mod_base/grc/$mod_name$grc_pre$block_name$block_index.xml"

echo "Files Copied"

## Replace Strings

# Replace in impl.cc
sed -i "s/$block_name/$block_name$block_index/g" "$mod_base/lib/$block_name$block_index$c_lib_post"


# Replace in impl.h
sed -i "s/$block_name/$block_name$block_index/g" "$mod_base/lib/$block_name$block_index$h_lib_post"


sed -i "s/$block_name_upper/$block_name_upper$block_index/g" "$mod_base/lib/$block_name$block_index$h_lib_post"


# Replace in .h
sed -i "s/$block_name/$block_name$block_index/g" "$mod_base/include/$mod_name/$block_name$block_index$h_head_post"

sed -i "s/$block_name_upper/$block_name_upper$block_index/g" "$mod_base/include/$mod_name/$block_name$block_index$h_head_post"

# Replace in .xml
sed -i "s/$block_name/$block_name$block_index/g" "$mod_base/grc/$mod_name$grc_pre$block_name$block_index.xml"

echo "Text Replaced"

