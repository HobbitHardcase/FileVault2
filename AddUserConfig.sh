#!/bin/sh

# Name:  AddUserFilevault2.sh
# Date:  26 Oct 2016 v2.0
# Author:  Daniel Ebeck (d.n.ebeck@gmail.com)
# Purpose:  used to authorise users on FileVault2 where the encryption has already been activated
# Updates:  
#
# Prerequisites - 	OSX10.10.x+ as the security command has been updated
#					CocoaDialog
#					FileVault2 activated using the admin details below
#					An Institutional FV2 key as defined below
#					
#
# NOTE: you may want to turn off logging (comment out 5 lines under #Globals & Loging) so that no passwords
# are captured.

# Globals & Logging	
# LOGPATH='Library/Logs'  # change this line to point to your local logging directory
# if [[ ! -d "$LOGPATH" ]]; then
# 	mkdir $LOGPATH
# fi
# set -xv; exec 1> $LOGPATH/activatefilevaultlog.txt 2>&1  # you can name the log file what you want
version=2.0

# set this to the AD domain name
AD='YOUR_AD_DOMAIN'  
currentAD=`dsconfigad -show | grep -i "active directory domain" | awk '{ print $5 }'`

####  set this to the location of cocoaDialog on your systems
CD="/usr/local/cocoaDialog.app/Contents/MacOS/cocoaDialog"
osVersion=`sw_vers -productVersion | cut -d. -f1,2`

# Grab current user name
loggedInUser=`id -un`

#### this section will get stored in the log file if left on and will store the end user's password and
#### the admin user's password in clear text.  If not testing, disable logging by commenting out lines
#### under the Globals & Logging section above.
# now we need to add the new UID to FV2
# Use cocoaDialog to get the current user's password

	
userPassword=`$CD standard-inputbox --title "Authorise your account for FileVault" --no-show --no-cancel --informative-text "To be able to reboot this Mac, please enter your $AD password:" --float`
userPassword=`echo $userPassword | awk '{ print $2 }'`
	
	
# create the plist file:
	echo '<?xml version="1.0" encoding="UTF-8"?>
	<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
	<plist version="2.0">
	<dict>
	<key>Username</key>
	<string>'ADMIN_SHORT_NAME'</string>
	<key>Password</key>
	<string>'ADMIN_PASSWORD'</string>
	<key>AdditionalUsers</key>
	<array>
	    <dict>
	        <key>Username</key>
	        <string>'$loggedInUser'</string>
	        <key>Password</key>
	        <string>'$userPassword'</string>
	    </dict>
	</array>
	</dict>
	</plist>' > /tmp/enableFVUser.plist  
	
# now enable FileVault by calling a secure script
sudo /var/root/Documents/AddFilevault2user.sh

# remove the LaunchAgent so that this command does not run at subsequent logins
rm -f /Users/$loggedInUser/Library/LaunchAgents/com.user.encryption.plist

exit 0
