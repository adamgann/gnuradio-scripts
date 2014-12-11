#!/usr/bin/expect
# 
# Test out copy_block.sh



# Params
set mod_name "testfilecopy"
set block_name "square"
set block_index "2"

# Run the script
spawn copy_block.sh

expect "Enter the mod name without the 'gr-' prefix: "
send "testfilecopy\r"

expect "Enter the block name: "
send "square\r"

expect "Enter the index for the new block: "
send "2\r"

expect "In gr-$mod_name, I am copying the contents of $block_name to $block_name$block_index. Correct?"

send "y\r"


interact
