#!/bin/bash

#yum install docker net-tools expect -y
#systemctl restart docker

apt-get install expect -y
docker stop $(docker ps -aq)
docker rm $(docker ps -aq)
systemctl restart docker

IP=$(ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|grep -v 172|awk '{print $2}'|tr -d "addr:")
OVPN_DATA="/root/ovpn-data"
rm -rf $OVPN_DATA
mkdir $OVPN_DATA
passKey="hjRkAEdGf"

docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_genconfig -u udp://$IP


echo "##########################start 1st expect#############"

/root/scripts/step2.sh

echo "##########################Finish 1st expect#############"

docker run -v $OVPN_DATA:/etc/openvpn -d -p 1194:1194/udp --cap-add=NET_ADMIN kylemanna/openvpn

echo "##########################start 2st expect#############"

/root/scripts/step3.sh

echo "##########################Finish 2st expect#############"
docker run -v $OVPN_DATA:/etc/openvpn --log-driver=none --rm kylemanna/openvpn ovpn_getclient CLIENTNAME > CLIENTNAME.ovpn
