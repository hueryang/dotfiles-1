#!/usr/bin/env zsh

if [[ ! -e "$HOME/.secret/$1" ]] ; then
    echo "$HOME/.secret/$1 does not exist"
    exit 1
fi

source "$HOME/.secret/$1" 

verificationcode=`oathtool --totp --base32 -d6 $OATH_SECRET` 


expect <(cat <<EOD
spawn ssh $JUMPER_SERVER 

expect  "*Verification code:" 
send "$verificationcode\r"  

expect  "*Password:" 
send "$AD_PASSWORD\r" 

expect "*Please enter your Login Ip:" 
send "$2\r" 
interact

EOD
)

