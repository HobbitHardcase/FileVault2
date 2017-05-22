# FileVault2
Scripting to help with FileVault2 in an Active Directory environment.

With many thanks to Rich Trouton (https://derflounder.wordpress.com/).
Without his insightful and detailed explanations, this wouldn't have
worked.

The corporate world often mandates the use of encryption for laptops.
This can cause problems for Macs, as FileVault2 needs to be activated
individually for each mobile account on the system. Local accounts will
be added to the list of authorised accounts at creation, but Mobile
accounts such as Active Directory aren't.

The scripts here will allow this process to be semi-automated, so that
when a user signs in for the first time, they are presented with an
additional dialogue box which will add them to the authorised users
list.

For ease of use, you should consider creating an institutional FV2 key
(as detailed on RT's website).

The .packproj file is an Iceberg project file. This allows you to
package the scripts so that they can be deployed via DeployStudio, or
your preferred method.

Drawbacks: 
• The Mac needs to be unlocked by an authorised user before
the new user can sign in for the first time. 
• The new user needs to spell their password correctly when they enter
 it in the dialogue box. 
• If the user subsequently changes their AD password outside of macOS
(i.e. on a web portal), the password will go out of sync.