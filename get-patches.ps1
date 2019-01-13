#get-patches
$Z = Get-Credential
#$B = Read-Host -Prompt 'Hostname'

ForEach ($B in Get-Content .\audit-servers2.txt) {Get-HotFix -ComputerName $B -Cred $Z |export-csv hostname_$B.csv}
