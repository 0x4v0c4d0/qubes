#!/bin/bash
# Import all ovpn config files in folder with given credentials
# Put this script in folder with .ovpn files then run
#  import path/to/ovpns/ username password
# Or simple in case no auth required
#  import path/to/ovpns/

CONFIGS_PATH="$1"
USERNAME="$2" # Optional
PASS="$3" # Optional

for f in $(ls -1 "${CONFIGS_PATH}/"*.ovpn)
do    
        sudo nmcli connection import type openvpn file $f
	if [[ "${PASS}" == '' ]]; then
    		continue
  	fi
        name=`basename -s .ovpn $f`;
        sudo nmcli connection modify "${name}" vpn.user-name "${USERNAME}"
        sudo nmcli connection modify "${name}" vpn.secrets password="${PASS}"
	sudo nmcli connection modify "${name}" +vpn.data password-flags=0
	sudo nmcli connection modify "${name}" +vpn.data cert-pass-flags=0
	sudo echo '[vpn-secrets]' >> /etc/NetworkManager/system-connections/"${name}"
	sudo echo password="${PASS}" >> /etc/NetworkManager/system-connections/"${name}"
done
