#!/usr/bin/env zsh

function vpn(){
    
    if [[ "$1" == "sensetime" ]]; then
        code=`oathtool --totp --base32 -d6 WASBPQMYOM4HI2W5`
        echo "vpn.secrets.password:Passw0rd@123$code" | nmcli con up id 'sensetime-auth-bj' passwd-file /dev/stdin

    elif [[ "$1" == "google" ]]; then
    else
    fi

}
