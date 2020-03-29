#!/usr/bin/env zsh

function oath(){
    if [[ ! -e "$HOME/.secret/$1" ]] ; then
        echo "$HOME/.secret/$1 does not exist"
        exit 1
    fi

    source "$HOME/.secret/$1" 

    oathtool --totp --base32 -d6 $OATH_SECRET 

}
