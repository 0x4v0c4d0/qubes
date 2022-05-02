# Set up debian-vpn template qube

# Install OpenVPN client for NetworkManager
sudo apt-get install openvpn network-manager-openvpn --yes

# Import configs
# Configs should be imported into vpn template qube
sudo chmod +x /etc/myqubes/vpn/openvpn/import.sh
sudo /etc/myqubes/vpn/openvpn/import.sh /etc/myqubes/vpn/openvpn/configs/free-vpngate

# Import configs with credentials:
#sudo /etc/myqubes/vpn/openvpn/import.sh /etc/myqubes/vpn/openvpn/configs/free-protonvpn username password

# And you can import any other configs
#sudo /etc/myqubes/vpn/openvpn/import.sh folder/with/ovpn/configs/ username password
#sudo /etc/myqubes/vpn/openvpn/import.sh folder/with/ovpn/configs/
