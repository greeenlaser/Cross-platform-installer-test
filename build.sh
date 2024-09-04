#!/bin/bash

#--------------------------
#first parameter must be either 'y' (yes) or 'n' (no)
#this either bypasses or doesnt bypass the final check
#at the end of this script to wait for user input before exiting
#--------------------------

#if first parameter is empty
if [ -z "$1" ]; then
    echo "---- No bypass parameter provided! You must either set first parameter as 'y' or 'n'."
    exit 1
#if first parameter is not a valid input
elif [ "$1" != 'y' ] && [ "$1" != 'n' ]; then
    echo "---- Parameter 1 '$1' is not a valid bypass state! Either pick 'y' or 'n'. Defaulting to 'n'."
    exit 1
else
    echo "---- Chosen bypass state is '$1'."
    bypassState=$1
fi

#--------------------------
#second parameter must be either Debug or Release
#if left empty or if invalid variable is chosen then Debug is chosen
#this sets the build type for the executable
#--------------------------

#if second parameter is empty
if [ -z "$2" ]; then
    echo "---- No build type provided. Defaulting to 'Debug'."
    buildType="Debug"
#if second parameter is either Debug or Release
elif [ "$2" == 'Debug' ] || [ "$2" == 'Release' ]; then
    echo "---- Chosen build type is '$2'."
    buildType=$2
#if second parameter is not a build type
else
    echo "---- Parameter 2 '$2' is not a valid build type! Either pick 'Debug' or 'Release'."
    exit 1
fi

#--------------------------
#configure exe
#--------------------------
echo "---- Started CMake configuration..."
cmake -S . -B build -DCMAKE_BUILD_TYPE="$buildType"
if [ $? -ne 0 ]; then
    echo "---- CMake configuration failed."
    exit 1
fi

#--------------------------
#build exe
#--------------------------
echo "---- Started CMake build"
cmake --build build
if [ $? -ne 0 ]; then
    echo "---- CMake build failed."
    exit 1
fi

#--------------------------
#final check to wait for user input
#before closing shell file if first parameter was 'y'
#--------------------------
if [ "$bypassState" == 'y' ]; then
read -p "---- Press any key to exit..."
fi
