#!/usr/bin/env zsh

function gauth(){
    
    if [[ "$1" == "sensetime" ]]; then
        oathtool --totp --base32 -d6 WASBPQMYOM4HI2W5
    elif [[ "$1" == "google" ]]; then
    else
    fi

}
