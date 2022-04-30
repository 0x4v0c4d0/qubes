# My Qubes OS setup

This is guide will walk you through the process of installing Qubes OS and also, in addition to the [official guide](https://www.qubes-os.org/doc/installation-guide/#hardware-requirements), this repo will give you configuration files and additional instructions to set up the system environment exactly like mine

## Requirements

You need hardware with virtualization supported. [Read more](https://www.qubes-os.org/doc/installation-guide/#hardware-requirements) and google you hardware virtualization compatibilities

And [USB-stick with flashed Qubes OS iso on it](https://www.qubes-os.org/doc/installation-guide/#copying-the-iso-onto-the-installation-medium)

## BIOS Setup

Before the OS setup boot in BIOS then find and enable all [required virtualization features](https://www.qubes-os.org/hcl/#list-columns): HVM, IOMMU, TPM, SLAT

Set up BIOS admin&user passwords

## Qubes OS Installation

Follow the [official guide](https://www.qubes-os.org/doc/installation-guide/#installation)

Set up the disk password

Set up the system languages

Set up the language layout hotkeys

Set up the user password

Choose debian as default and leave preconfigured VMs

## Configuring

When Qubes OS installed, boot, login and configure the system

Connect to the Internet first

### Basic Debian Template
Set the netVM of debian template to sys-firewall

Run in the debian template terminal:
```
sudo apt-get install git
git clone https://github.com/imnetcat/myqubes
sudo mv myqubes /etc
cd /etc/myqubes/setup
sudo chmod +x *.sh
sudo ./base-template.sh
```

Then shutdown debian template
Start & execute following in the any AppVM that has an debian as template for set up the my terminal appearance (the command must be executed only once, on the next appvm boot everything will already be configured)
```
sudo /etc/myqubes/setup/appvm.sh
```

### VPN Qube 

Clone base debian template into debian-vpn template and run into created qube
```
sudo /etc/myqubes/setup/vpn-template.sh
```

_For details see: [Installation openvpn for NetworkManager](https://www.ivpn.net/setup/linux-netman/)_


Create sys-vpn NetVM, set the debian-vpn template as a template, add `network-manager` and `qubes-firewall` into services of the qube then run into created qube
```
sudo /etc/myqubes/setup/vpn.sh
```

_For details see: [Installation of vpn qube](https://github.com/Qubes-Community/Contents/blob/master/docs/configuration/vpn.md#set-up-a-proxyvm-as-a-vpn-gateway-using-networkmanager)_

Then download and copy to the sys-vpn qube openvpn-compatible configs. 

Import ovpn configs 
```
sudo /etc/myqubes/setup/openvpn/import.sh /path/to/ovpns username password
```
