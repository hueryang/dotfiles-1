#!/usr/bin/env zsh

verificationcode=`oathtool --totp --base32 -d6 WASBPQMYOM4HI2W5`


expect <(cat <<EOD
spawn ssh jump01.bj.sensetime.com 

expect  "*Verification code:" 
send "$verificationcode\r"  

expect  "*Password:" 
send "Passw0rd@123\r" 

expect "*Please enter your Login Ip:" 
send "$1\r" 
interact

EOD
)

