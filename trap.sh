#!/bin/bash

set -e

failure(){
    echo "Failed at: $1 : $2"
}

trap 'failure "${LINENO}" "$BASH_COMMAND"' ERR

echo "Hi Prasad"

echhooo "Hi Durga, How are you prasad"

echo "DOing graet. How about you Durga"