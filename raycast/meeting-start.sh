#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Meeting Start
# @raycast.mode silent

LIGHT_IPS=("192.168.1.133" "192.168.1.206")

for ip in "${LIGHT_IPS[@]}"; do
  curl -s -o /dev/null --max-time 2 -X PUT "http://$ip:9123/elgato/lights" \
    -H "Content-Type: application/json" \
    -d '{"numberOfLights":1,"lights":[{"on":1,"brightness":30,"temperature":213}]}' &
done
wait

"$HOME/.dotfiles/bin/audioctl" output "Shure MV7"
