#Get-ADGroupMember -Identity "CN=Patch-Non_Prod_Group01,OU=Patching,OU=Security Groups,DC=LORD,DC=LOCAL" -properties * |Select-Object Name,Description |Format-Table Name, Description,  -AutoSize

#you do it something like this:
#get-adgroupmember "Patch-Non_Prod_Group01" | get-adcomputer -prop * | Select-Object name, operatingsystem, Description |Export-Csv .\Patch-Non_Prod_Group01.csv -NoTypeInformation

#get-adgroupmember "Patch-Non_Prod_Group02" | get-adcomputer -prop * | Select-Object name, operatingsystem, Description |Export-Csv .\Patch-Non_Prod_Group02.csv -NoTypeInformation

#get-adgroupmember "Patch-Prod_Crit_Group01" | get-adcomputer -prop * | Select-Object name, operatingsystem, Description |Export-Csv .\Patch-Prod_Crit_Group01.csv -NoTypeInformation

#get-adgroupmember "Patch-Prod_Crit_Group02" | get-adcomputer -prop * | Select-Object name, operatingsystem, Description |Export-Csv .\Patch-Prod_Crit_Group02.csv -NoTypeInformation

#get-adgroupmember "Patch-Prod_Group01" | get-adcomputer -prop * | Select-Object name, operatingsystem, Description |Export-Csv .\Patch-Prod_Group01.csv -NoTypeInformation

#get-adgroupmember "Patch-Prod_Group02" | get-adcomputer -prop * | Select-Object name, operatingsystem, Description |Export-Csv .\Patch-Prod_Group02.csv -NoTypeInformation

#get-adgroupmember "Patch-Prod_Group03" | get-adcomputer -prop * | Select-Object name, operatingsystem, Description |Export-Csv .\Patch-Prod_Group03.csv -NoTypeInformation

#get-adgroupmember "Patch-Prod_Group04" | get-adcomputer -prop * | Select-Object name, operatingsystem, Description |Export-Csv .\Patch-Prod_Group04.csv -NoTypeInformation

# Another type of example, you pick the group
#get-adgroupmember "SWDExclusion" | get-adcomputer -prop * | Select-Object name, operatingsystem, Description |Export-Csv .\SWDExclusion.csv -NoTypeInformation

$Gizzle = Read-Host -Prompt 'Enter the Group you want to look up'

get-adgroupmember $Gizzle -Recursive | Select-Object name, operatingsystem, Description |Export-Csv .\foo1.csv -NoTypeInformation 