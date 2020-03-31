#!/usr/bin/env zsh

# For Tunnelblick on macos, please refer to 
# https://ifritltd.com/2018/01/15/automating-vpn-connection-when-using-multifactor-authentication-with-tunnelblick-on-macos/
#

function vpn(){
    if [[ ! -e "$HOME/.secret/$1" ]] ; then
        echo "$HOME/.secret/$1 does not exist"
        exit 1
    fi

    source "$HOME/.secret/$1" 

    code=`oathtool --totp --base32 -d6 $OATH_SECRET`     

    if [[ "$OSTYPE" == "linux-gnu" ]]; then

        echo "vpn.secrets.password:$AD_SECRET$code" > $HOME/.secret/$1-vpn
        nmcli con up id '$1' passwd-file $HOME/.secret/$1-vpn
        
    elif [[ "$OSTYPE" == "darwin"* ]]; then

        echo -e "$AD_ID\n$AD_SECRET$code" > $HOME/.secret/$1-vpn
        osascript -e "tell application \"/Applications/Tunnelblick.app\"" -e "connect \"$1\"" -e "end tell"

    fi
}
