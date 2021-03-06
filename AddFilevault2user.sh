#!/bin/sh

# Name:  AddFilevault2user.sh
# Date:  04 May 2016 v1.0
# Author:  Daniel Ebeck (d.n.ebeck@gmail.com)
# Purpose:  Add a user to the FileVault Authorised User list using a generated plist
# Updates:  
#
# Prerequisites - 	OSX10.10.x+ as the security command has been updated
#					An Institutional FV2 key installed in /Library/Keychains
#					The user-specific plist must have been generated by the AddUserConfig.sh

sudo fdesetup add -inputplist < /tmp/enableFVUser.plist

exit 0
