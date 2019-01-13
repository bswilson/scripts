# group-managedby-lookup.ps1
# by Scott Wilson
# last updated 9/24/18
#
# Get info about who controls membership of a Group
#
$GName = Read-Host -Prompt 'Enter the Group you want to look up'
Get-ADGroup -Filter "name -like '*$GName*'" -Properties ManagedBy |Select-Object name, @{N='Group is Managed By';E={
    (Get-ADUser ($_.ManagedBy)).SamAccountName
    }
}