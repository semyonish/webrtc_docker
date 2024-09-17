#!/bin/bash

DEPOT_SRC="depot_tools"

if [ -d "$DEPOT_SRC" ]; then
    echo "'$DEPOT_SRC' exists."
    cd $DEPOT_SRC
    git pull origin main
else
    echo "'$DEPOT_SRC' doesn't exists."
    git clone https://chromium.googlesource.com/chromium/tools/depot_tools.git
    cd $DEPOT_SRC
fi
                                                                        
export PATH=$PATH:"$(pwd)"
cd ..