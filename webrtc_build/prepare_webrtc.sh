#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <hash> <platform>"
    exit 1
fi

HASH=$1
PLATFORM=$2

if ! [[ "$HASH" =~ ^[a-f0-9]{40}$ ]]; then
    echo "The first argument must be a hash (40 hexadecimal characters)."
    exit 1
fi

if [[ "$PLATFORM" != "ios" && "$PLATFORM" != "android" ]]; then
    echo "The second argument must be 'ios' or 'android'."
    exit 1
fi

echo "============================================================"
echo "Commit hash: $HASH"
echo "Platform: $PLATFORM"
echo "============================================================"

WEBRTC_SRC="src"
DEPOT_SRC="depot_tools"

# clone depot_tools
if [ -d "$DEPOT_SRC" ]; then
    echo "Folder $DEPOT_SRC exists. Pulling..."
    echo "------------------------------------------------------------"
    cd $DEPOT_SRC
    git pull origin main
else
    echo "Folder $DEPOT_SRC doesn't exists. Cloning..."
    echo "------------------------------------------------------------"
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
    cd $DEPOT_SRC
fi

# add depot_tools to PATH                                                                        
export PATH=$PATH:"$(pwd)"
cd ..                               
echo "============================================================"

# clone WebRTC
if [ -d "$WEBRTC_SRC" ]; then
    echo "'$WEBRTC_SRC' exists. Just sync."
    echo "------------------------------------------------------------"
else
    echo "'$WEBRTC_SRC' doesn't exists. Need fetch and sync."
    echo "------------------------------------------------------------"
    fetch --nohooks webrtc_$PLATFORM # clone with google utils	
    echo "------------------------------------------------------------"
fi

gclient sync # sync with google utils

echo "============================================================"
# reset to commit with hash 
cd src
git reset --hard $HASH

if [ "$1" == "android" ]; then
    echo "============================================================"
    echo "Start install build deps."
    echo "------------------------------------------------------------"
    ./build/install-build-deps.sh
fi
