#!/bin/bash


# set -e

# failure(){
#     echo "Failed at: $1 : $2"
# }

# trap 'failure "${LINENO}" "$BASH_COMMAND"' ERR   #ERR is error signal

# echo "Hi Prasad"

# echhooo "Hi Durga, How are you prasad"

# echo "DOing graet. How about you Durga"


#another example of trap

err_report(){
    echo "Error on line $1"
}
trap 'err_report $LINENO' ERR 

echo "Hi Prasad"

echhooo "Hi Durga, How are you prasad"

echo "DOing graet. How about you Durga"

echo "hello" | grep foo