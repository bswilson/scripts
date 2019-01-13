# China systems
# Get-ADComputer -Filter {enabled -eq $true} -properties *|select Name, DNSHostName, OperatingSystem, LastLogonDate

$MyFile = "C:\Users\scott_wilson\OneDrive - LORD Corporation\Scripts\Domain_Controller_Systems.csv"
if (Test-Path $MyFile) 
{
  Remove-Item $MyFile
}

#Domain Controllers
Get-ADComputer -Filter {enabled -eq $true} -SearchBase "OU=Domain Controllers, DC=LORD, DC=LOCAL" -Properties Name, CanonicalName, Description, OperatingSystem, IPv4Address | Select-Object Name, CanonicalName, Description, OperatingSystem, IPv4Address | Export-Csv -Append "C:\Users\scott_wilson\OneDrive - LORD Corporation\Scripts\Domain_Controller_Systems.csv" -NoTypeInformation
