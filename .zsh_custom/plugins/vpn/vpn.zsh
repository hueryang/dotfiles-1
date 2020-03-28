#!/usr/bin/env zsh

function vpn(){
    
    if [[ "$1" == "sensetime" ]]; then
        code=`oathtool --totp --base32 -d6 WASBPQMYOM4HI2W5`     
        if [[ "$OSTYPE" == "linux-gnu" ]]; then
            echo "vpn.secrets.password:Passw0rd@123$code" | nmcli con up id 'sensetime-auth-bj' passwd-file /dev/stdin
        elif [[ "$OSTYPE" == "darwin"* ]]; then
            echo -e "zhoumingjun\nPassw0rd@123$code" > /Users/zhoumingjun/.zsh_custom/plugins/vpn/secret
            osascript -e "tell application \"/Applications/Tunnelblick.app\"" -e "connect \"sensetime-auth-bj\"" -e "end tell"
        fi
    fi
}
