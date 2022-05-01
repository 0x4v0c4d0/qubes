# Set up sys-vpn AppVM

# Set up autostart

# Wait until network setup
echo 'while ! ping -c 1 -W 1 1.1.1.1; do' >> /rw/config/rc.local
echo '   sleep 1' >> /rw/config/rc.local
echo 'done' >> /rw/config/rc.local
# Automatically connect to the one of imported ovpn configs
# vpngate_vpn157674668.opengw.net_udp_1194 - one of free public VPN server, you can replace it with anyone else
echo 'nmcli connection up vpngate_vpn157674668.opengw.net_udp_1194' >> /rw/config/rc.local

# Set up killswitch
# See https://github.com/Qubes-Community/Contents/blob/master/docs/configuration/vpn.md
# Block forwarding of connections through upstream network device
# (in case the vpn tunnel breaks)
sudo echo 'iptables -I FORWARD -o eth0 -j DROP' >> /rw/config/qubes-firewall-user-script
sudo echo 'iptables -I FORWARD -i eth0 -j DROP' >> /rw/config/qubes-firewall-user-script
sudo echo 'ip6tables -I FORWARD -o eth0 -j DROP' >> /rw/config/qubes-firewall-user-script
sudo echo 'ip6tables -I FORWARD -i eth0 -j DROP' >> /rw/config/qubes-firewall-user-script

# Import configs
sudo chmod +x /etc/myqubes/vpn/openvpn/import.sh
sudo /etc/myqubes/vpn/openvpn/import.sh /etc/myqubes/vpn/openvpn/configs/free-vpngate

# Import configs with credentials:
#sudo /etc/myqubes/vpn/openvpn/import.sh /etc/myqubes/vpn/openvpn/configs/free-protonvpn username password

# And you can import any other configs
#sudo /etc/myqubes/vpn/openvpn/import.sh folder/with/ovpn/configs/ username password
#sudo /etc/myqubes/vpn/openvpn/import.sh folder/with/ovpn/configs/
