#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <hash>"
    exit 1
fi

HASH=$1

if ! [[ "$HASH" =~ ^[a-f0-9]{40}$ ]]; then
    echo "The first argument must be a hash (40 hexadecimal characters)."
    exit 1
fi

./prepare_webrtc.sh $HASH android


echo "============================================================"
./build/install-build-deps.sh
