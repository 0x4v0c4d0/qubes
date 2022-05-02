#!/bin/bash
# Import all ovpn config files in folder with given credentials
# Put this script in folder with .ovpn files then run
#  import path/to/ovpns/ username password
# Or simple in case no auth required
#  import path/to/ovpns/

CONFIGS_PATH="$1"
USERNAME="$2" # Optional
PASS="$3" # Optional

# Create folder for certs if it was not exist
mkdir -p /home/user/.cert/nm-openvpn

for f in $(ls -1 "${CONFIGS_PATH}/"*.ovpn)
do
	# Import config
        nmcli connection import type openvpn file $f
	# Get config name (same as .ovpn file name
        name=`basename -s .ovpn $f`;
	# openvpn could try to search for certs and passwords in invalid location
	nmcli connection modify "${name}" +vpn.data password-flags=0
	nmcli connection modify "${name}" +vpn.data cert-pass-flags=0
	# Move cert from /root/.cert to /home/user/.cert
	nmcli connection modify "${name}" +vpn.data ca="/home/user/.cert/nm-openvpn/${name}-ca.pem"
	nmcli connection modify "${name}" +vpn.data key="/home/user/.cert/nm-openvpn/${name}-key.pem"
	nmcli connection modify "${name}" +vpn.data cert="/home/user/.cert/nm-openvpn/${name}-cert.pem"
		
	# If username & password not specified then do not add them
	if [[ "${PASS}" == '' ]]; then
    		continue
  	fi
        nmcli connection modify "${name}" vpn.user-name "${USERNAME}"
        nmcli connection modify "${name}" vpn.secrets password="${PASS}"
	nmcli connection modify "${name}" +vpn.data ta="/home/user/.cert/nm-openvpn/${name}-tls-auth.pem"
done

# Move cert from /root/.cert to /home/user/.cert
sudo mv -v /root/.cert/nm-openvpn/* /home/user/.cert/nm-openvpn/
