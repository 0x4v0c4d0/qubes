# This should be executed in base debian template for adding
#  the wasabi wallet appmenu entry in case of original 
#  app menu entry missang after installing
# After executing this script you should execute `qvm-sync-appmenus debian-11` from dom0 qube for sync appmenu

sudo echo '[Desktop Entry]' >> /usr/share/applications/wassabee.desktop
sudo echo 'Version=1.0' >> /usr/share/applications/wassabee.desktop
sudo echo 'Type=Application' >> /usr/share/applications/wassabee.desktop
sudo echo 'Terminal=false' >> /usr/share/applications/wassabee.desktop
sudo echo 'Name=Wasabi Wallet' >> /usr/share/applications/wassabee.desktop
sudo echo 'GenericName=Cryptowallet' >> /usr/share/applications/wassabee.desktop
sudo echo 'Comment=' >> /usr/share/applications/wassabee.desktop
sudo echo 'Categories=Cryptowallet' >> /usr/share/applications/wassabee.desktop
sudo echo 'Exec=wassabee' >> /usr/share/applications/wassabee.desktop
