#Introduction

A few scripts useful for working with GNU Radio and Linux in general. Most helpful if these are added to the PATH at startup by editing your ~/.bashrc 

# Description

### Add GR to GIT
Shortcut to adding all the folders in a GNU Radio out-of-tree directory except for the build folder. 

### GR Size Buffers
Uses sysctl to set the network buffers based on the recommendations spit out by GNU Radio when running with a USRP. Needs to be run as root.

### Move File
Used when you want to move a block from one out-of-tree module to another. First create the new block in the new out-of-tree directory using gr_modtool. Then call the Move File script to copy over the four most important files from the original out-of-tree directory, overwriting the blank ones in the new directory. The text of the files will be updated to match the new directory, where necessary. 

The files updated are:

blockname_impl.cc
blockname_impl.h
blockname.h
modname_blockname.xml


### Copy Block
Used when you want to make a copy of a block in the same working directory but want to distinguish the new block with an index. This is useful when you want to test out another version of a block but still would like to keep the old version functional. This would allow the creation of "blockname" and blockname2", for example.

Run the script from any directory. The new block will automatically be created and all of the necessary files updated. Go to the build directory and run make to build the new files. Both the new and original should be ready to go.

The files updated are:

blockname$index_impl.cc
blockname$index_impl.h
blockname$index.h
modname_blockname$index.xml

Currently the script only works with numbers, but that will be changed soon to allow for strings. 
