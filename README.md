# QubesOS setup & configuration

This is guide will walk you through the process of installing Qubes OS and also, in addition to the [official guide](https://www.qubes-os.org/doc/installation-guide/#hardware-requirements), this repo will give you configuration files and additional instructions to set up the system environment, VPN qubes

## Requirements

- You need hardware with virtualization supported. [Read more](https://www.qubes-os.org/doc/installation-guide/#hardware-requirements) and google you hardware virtualization compatibilities

- And [USB-stick with flashed Qubes OS iso on it](https://www.qubes-os.org/doc/installation-guide/#copying-the-iso-onto-the-installation-medium)

- Enable all [required virtualization features](https://www.qubes-os.org/hcl/#list-columns): HVM, IOMMU, TPM, SLAT

- (recomendation) Set up BIOS admin&user passwords

## Installation

Follow the [official guide](https://www.qubes-os.org/doc/installation-guide/#installation)

Set up the disk password

Set up the system languages

Set up the language layout hotkeys

Set up the user password

Choose debian as default and leave preconfigured VMs

## Configuring

When Qubes OS installed, boot, login and configure the system

_Connect to the Internet first_

### Sceenshots
For automoving screenshots to the one of appwm use [script](https://github.com/scott-m-willett/qvm-screenshot)

### Template: debian
Download this repo. 

Copy it to the base debian template.

Make folder for repo: `sudo mkdir /etc/myqubes`

Save repo globally for debian templates and AppVM's: `sudo mv path/to/this/repo/* /etc/myqubes`

Give access to execute scripts: `sudo chmod +x /etc/myqubes/setup/*.sh`

Execute script that prepears base debian template for use: `sudo /etc/myqubes/setup/base-template.sh`

Then shutdown template.

### Template: debian-cryptowallet

Clone base debian template. Launch it.

Then choose wallet to install. See list of BTC wallets that
- non-custodial (you own you keys)
- desktop (for installing in our qube)
- privacy and anonymous driven

See:
1. [Wassabi wallet](https://wasabiwallet.io/)

  Manual installation from https://wasabiwallet.io/#download

2. [Electrum](https://electrum.org/)

  Installation: `sudo snap install electrum`
  
3. _Know another one?... pull request welcome_

Install what you want. I'd preffer wassabi wallet.

### Template: dev-template

If you need safe develop envirenment clone the base debian template and then run into clone template:
```
sudo /etc/qubes/setup/dev.sh
```

### Next let's configure AppWM's

Execute following in the all new AppVM that we created bellow
```
sudo /etc/myqubes/setup/appvm.sh
```

### VPN Qube 

Clone base debian template into debian-vpn template and run into created qube
```
sudo /etc/qubes/setup/vpn-template.sh
```

_For details see: [Installation openvpn for NetworkManager](https://www.ivpn.net/setup/linux-netman/)_


Create sys-vpn NetVM, set the debian-vpn template as a template, add `network-manager` and `qubes-firewall` into services of the qube then run into created qube
```
sudo /etc/myqubes/setup/vpn.sh
```

_For details see: [Installation of vpn qube](https://github.com/Qubes-Community/Contents/blob/master/docs/configuration/vpn.md#set-up-a-proxyvm-as-a-vpn-gateway-using-networkmanager)_

Some ovpn configs are preloaded, you can use this and you can import you own ovpn configs:
```
sudo /etc/myqubes/setup/openvpn/import.sh /path/to/ovpns username password
```
or without creds
```
sudo /etc/myqubes/setup/openvpn/import.sh /path/to/ovpns
```

**(Recomendation): Edit `sudo nano /rw/config/rc.local` and set in the last line one of imported config of vpn server to which you want connect automatically after qube boot**

Setting up the sys-vpn done. Now you can use at as proxy for another AppVM or NetVM.
