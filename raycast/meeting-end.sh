#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Meeting End
# @raycast.mode silent

LIGHT_IPS=("192.168.1.133" "192.168.1.206")

for ip in "${LIGHT_IPS[@]}"; do
  curl -s -o /dev/null --max-time 2 -X PUT "http://$ip:9123/elgato/lights" \
    -H "Content-Type: application/json" \
    -d '{"numberOfLights":1,"lights":[{"on":0}]}' &
done
wait

# Restore audio output. First match wins, so put preferred devices first --
# the built-in speakers are named per model. Work machine (Pro) first, since
# that is where this runs almost all of the time.
OUTPUT_DEVICES=("MacBook Pro Speakers" "MacBook Air Speakers")

for device in "${OUTPUT_DEVICES[@]}"; do
  "$HOME/.dotfiles/bin/audioctl" output "$device" 2>/dev/null && exit 0
done

echo "No matching output device found" >&2
exit 1
