#!/usr/bin/expect

set timeout 1000
set passKey "hjRkAEdGf"
set OVPN_DATA "/root/ovpn-data"

spawn docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm -it kylemanna/openvpn easyrsa build-client-full CLIENTNAME nopass
expect "Enter pass phrase for /etc/openvpn/pki/private/ca.key:"
send "$passKey\r"

interact 
