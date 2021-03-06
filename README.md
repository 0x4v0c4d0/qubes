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
For automoving screenshots from dom0 to the vault appwm use [this script](https://github.com/scott-m-willett/qvm-screenshot)

### Template: debian-template
Download this repo. 

Copy it to the base debian template.

Make folder for repo: `sudo mkdir /etc/myqubes`

Save repo globally for debian templates and AppVM's: `sudo mv path/to/this/repo/* /etc/myqubes`

Give access to execute scripts: `sudo chmod +x /etc/myqubes/setup/*.sh`

Execute script that prepears base debian template for use: `sudo /etc/myqubes/setup/base-template.sh`

Then shutdown template.

### Template: windows-10-x64-template
Download windows iso, put in into untrusted qube. Or download it on usb, then connect usb to untrusted qube.

Then run in dom0 terminal:

```
qvm-create --class TemplateVM --property virt_mode=HVM --property kernel='' --label black windows-10-x64-template
qvm-prefs windows-10-x64-template memory 4096
qvm-prefs windows-10-x64-template maxmem 4096
qvm-prefs windows-10-x64-template kernel ''
qvm-prefs windows-10-x64-template qrexec_timeout 7200
qvm-volume extend windows-10-x64-template:root 60g
```

Start the qube. DO NOT CONNECT QUBE TO THE INTERNET BEFORE INSTALLATION DONE.
Replace with you windows iso path

```
qvm-start --cdrom=untrusted:/home/user/windows_install.iso windows-10-x64-template
```

Then install Windows as usually. 

**Recomendation**: install the lightest edition - Windows Home edition.

**Note**: Install on the first disk

**Note**: windows qube could be shutdowned unexpectly a several times, just restart it and wait after installation done.

**Note**: _see [windows standalone installation](https://github.com/Qubes-Community/Contents/blob/master/docs/os/windows/windows-vm41.md#summary-installing-windows-via-cli) and [windows template installation](https://github.com/Qubes-Community/Contents/blob/master/docs/os/windows/windows-vm41.md#summary-installing-windows-via-cli) official tutorial for details_

Once Windows is installed and working, as administrator in Windows, set: `powercfg -H off` and pause windows updates as max as can in Settings->Updates&Security->Advance Options

Then go to Settings->Devices->Display and set up display resolution as you wish. By default window is so small.

Now install Qubes Windows Tools (QWT) according to [official article](https://github.com/Qubes-Community/Contents/blob/master/docs/os/windows/windows-tools41.md#installing-qubes-guest-tools-in-windows-vms).

And finally install all windows software you need.

**Optionally**: Activate windows, type in cmd as admin:
```
slmgr -ipk 7HNRX-D7KGG-3K4RQ-4WPJ4-YTDFH
slmgr /skms kms.03k.org
slmgr /ato
```

ignore errors if occurs, check is windows activated

[See details](https://mipped.com/f/threads/bystraja-aktivacija-ljuboj-versii-windows-office-bez-programm-obnovlenija-rabotajut.89087/)

**Optionally**: My own personalizations:
- Display resolution 1920x1080
- Settings->Personalization->Colors: "Choose your color": Dark and check "Automatically pick an accent color from background"
- Browser->Settings->Appearance: Dark
- Browser->Settings->Start: Open previos session
- Setup wallpapers

### AppVM: cryptowallet

Create default AppVM with whonix workstation as template.

Then choose wallet to install. See list of BTC wallets that
- non-custodial (you own you keys)
- desktop (for installing in our qube)
- privacy and anonymous driven

See:
1. [Wassabi wallet](https://wasabiwallet.io/).

  Installation: [manual](https://wasabiwallet.io/#download) *Should be installed into AppVM, NOT IN SEPARATE TEMPLATE*

2. [Electrum](https://electrum.org/)

  Preinstalled in whonix workstation
  
3. [Monero](https://www.getmonero.org/downloads/#gui)

  Preinstalled in whonix workstation
  
4. _Know another one?... pull request welcome_

Choose what you want. I'd preffer wassabi wallet.

Manual install wassabi wallet according provided instruction bellow.

Some **warnings**:
- Wasabi wallet should be installed into AppVM (NOT into separate template)
- Manually installed software like Wasabi wallet sometimes not display into qube appmenu list. See [Manually installed software](https://github.com/0x4v0c4d0/qubes/master/README.md#manually-installed-software)

### Template: dev-template

If you need safe develop envirenment clone the base debian template and then run into clone template:
```
sudo /etc/myqubes/setup/dev.sh
```

### Next let's configure AppWM's

Execute following in the all new AppVM that we created bellow
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

Some ovpn configs are preloaded, you can use this and you can import you own ovpn configs:
```
sudo /etc/myqubes/setup/openvpn/import.sh /path/to/ovpns username password
```
or without creds
```
sudo /etc/myqubes/setup/openvpn/import.sh /path/to/ovpns
```

**NB: Use TCP VPN connection for vpn-tor/tor-vpn/vpn-tor-vpn**

**NB: Edit `sudo nano /rw/config/rc.local` and set in the last line one of imported config of vpn server to which you want connect automatically after qube boot**

Setting up the sys-vpn done. Now you can use at as proxy for another AppVM or NetVM.

### Qubes colors

Set up for as you wish.

My setup: color meaning what a special things could do on this qube. Where every color means:
Black: no work on this qubes
Purple: qubes without Internet, base tasks, minimum browsing (or no browsing at all)
Blue: browsing, known sites visiting, such as forums and using telegram\irc\other common IM clients
Gray: skipped
Green: browsing same stuff
Yellow: browsing same special, important stuff
Orange: common browsing of some special, important staff
Red: very important browsing\other, should use secure network and can be disposable

![screenshot_2022-05-04_10:49:17](https://user-images.githubusercontent.com/104268605/166707949-eb688c13-04ff-426e-975e-6292c8f17eb1.png)

### Manually installed software
In case you install something like `dpkg -i package.deb` - new app sometimes not display into appmenu list. [This script](https://github.com/0x4v0c4d0/qubes/blob/master/cryptowallets/wasabi-app-menu-entry.sh) fix it for Wasabi wallet. See coments in thi script for details. For another app do analogically and see [oficial wiki](https://www.qubes-os.org/doc/app-menu-shortcut-troubleshooting/#what-if-my-application-has-not-been-automatically-included-in-the-list-of-available-a) about this problem.
