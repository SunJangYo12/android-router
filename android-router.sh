#!/bin/bash

IP=192.168.43.3

adb forward tcp:9191 tcp:9090 # translate
adb forward tcp:7070 tcp:7777 # webcam
adb forward tcp:2020 tcp:2222 # sshapk

# webserver linux to android
adb reverse tcp:8080 tcp:80
adb shell su -c sysctl -w net.ipv4.conf.wlan0.route_localnet=1
adb shell su -c iptables -t nat -A PREROUTING  -p tcp -d "$IP" -j DNAT --to 127.0.0.1   #wlan0 redirect
adb shell su -c iptables -t nat -A OUTPUT -d "$IP" -j DNAT --to-destination 127.0.0.1   #local redirect
