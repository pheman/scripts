#!/usr/bin/expect
set timeout 1000
set passKey "hjRkAEdGf"
set OVPN_DATA "/root/ovpn-data"
spawn docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn ovpn_initpki
expect {
"*Confirm removal:" { send "yes\r"; exp_continue }
"*Enter New CA Key Passphrase:" { send "$passKey\r"; exp_continue }
"*Re-Enter New CA Key Passphrase:" { send "$passKey\r"; exp_continue }
"*Easy-RSA CA*" { send "CN\r"; exp_continue }
"*Enter pass phrase for /etc/openvpn/pki/private/ca.key:" { send "$passKey\r"; exp_continue }
"*Enter pass phrase for /etc/openvpn/pki/private/ca.key:" { send "$passKey\r"}
}
