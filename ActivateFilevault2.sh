#!/bin/sh

# Name:  ActivateFilevault2.sh
# Date:  04 May 2016 v1.0
# Author:  Daniel Ebeck (d.n.ebeck@gmail.com)
# Purpose:  Activate FileVault2 with the defined Institutional key
# Updates:  
#
# Prerequisites - 	OSX10.10.x+ as the security command has been updated
#					An Institutional FV2 key installed in /Library/Keychains
#					The enable.plist installed by the FileVault.pkg

# Enable FV2 using the Keychain from the defined .plist. No unique recovery key is generated.
sudo fdesetup enable -keychain –norecoverykey -inputplist < /tmp/enable.plist

# Change the permissions on the AddFileVault2User.sh script so that it can be run by the user without su permissions
sudo chmod 4755 /var/root/Documents/AddFileVault2User.sh



exit 0
