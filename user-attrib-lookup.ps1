$list = Get-Content "C:\Users\scott_wilson\OneDrive - LORD Corporation\Scripts\list-test.txt" 

$list | ForEach-Object -Process {Get-ADUser $_ -Properties mail, title, manager |Select-Object name, mail, title, @{name="manager"; expression={((Get-ADUser $_.manager).samAccountName)}}} #| Export-Csv "C:\Users\scott_wilson\OneDrive - LORD Corporation\Scripts\poop.csv" -NoTypeInformation
