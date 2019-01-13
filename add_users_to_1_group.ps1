# Add a list of users to 1 AD Group
# Updated 10/6/2017 by bswilson@gmail.com
# can check this using Get-ADGroupMember "GroupNAME"
#
Import-Module ActiveDirectory
Import-CSV "C:\Scripts\users.csv" | ForEach-Object {
Add-ADGroupMember -Identity TestGroup1 -Members $_.USERNAME}
