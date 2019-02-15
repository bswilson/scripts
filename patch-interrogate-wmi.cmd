###########################################################################
########################                                                              
## Author: csharp
## Date: 11-10-2018
########################
## servers.csv = Newline seperated list of server hostnames and
## fields to be filled in by this script
## and known data to be carried forward to the output file.
## $out = results of the query for each server in servers.csv
## writen to out.csv.
## and any existing data from servers.csv.
## $c = Credential used to run WMI query. Requires admin rights.    
## Win32_QuickFixEngineering -This class returns only the updates supplied 
## by Component Based Servicing (CBS). Updates installed by msi not included. 
###########################################################################


# Load the CSV that has the report from NewSignature. This creates an object with methods and properties
# Includes field for the results of the wmi query "Validation_Results" and error message field.
# may refactor to use that approach at some point to reduce time it takes for large list of svrs

# FixMe: We need to create a standard structure.My default seems sane to me

$fdate = Get-Date -Format "MMddyyyhhmm"
$filename = [String]"sccm_agent_health_" + $fdate + ".csv"
$rootpath = "..\..\..\ps"
$inpath = "$rootpath\inventory\input"
$outpath = "$rootpath\inventory\out"
$fulloutpath = "$outpath\$filename"

#Get the latest inventory true up as input. 
$ns = Import-Csv -Path "$inpath\inventory_trueup_report_011420191052.csv"

#$ns = Import-Csv -Path "$env:HOMEPATH\desktop\remainder.csv"

# Prompt for a-account credentials
$c = Get-Credential


# iterate through each server in the csv and write out

ForEach($row in $ns)

{
# initialize 
    $SCCMClient = $null
    $error1 = $null
    $os = $null
    $drive = $null
    $btime = $null
    $lastboot =$null
    $lastpatch = $null
    $row.Query_Time = Get-Date -Format "MM-dd-yyy hh:mm tt"
    # if server does not respond to ping, write result and go to next server in array
    
    Write-Host $row

    If(-Not (Test-Connection -ComputerName $row.Name -Count 2 -Quiet)) 
    {

        $row.Validation_Results  = "Server did not respond to ping"  
        $row.Error_Message = "None. Server not online"      
    }
     Else {
        #Note that the ErrorVariable switch does not capture erors like "Access Denied" Need try/catch instead
    
    try {
            
        $SCCMClient = $(Get-WMIObject -Credential $c -ComputerName $row.Name -ErrorAction Stop  -Namespace root\ccm -Class sms_client).ClientVersion

        } catch {$row.Error_Message = $_ }
        
    try {        
        
        $row.OS_Name = $(Get-WMIObject -Credential $c -ComputerName $row.Name -ErrorAction stop  win32_operatingsystem).name
        
        } catch {$row.Error_Message = $_}

    Try {
            $server = $row.Name
            $os = Get-WmiObject -Class win32_OperatingSystem -Credential $c -computername $row.Name -ErrorAction Stop
            #continue if there were no errors
            $drive = Get-WMIObject Win32_Logicaldisk -Credential $c -filter "deviceid='$($os.systemdrive)'" -ComputerName $row.Name
            #get last boot date
            $lastboot = $os | select @{Name="LastBootUpTime";Expression={$_.ConverttoDateTime($_.lastbootuptime)}} | Select-Object -Property lastbootuptime
            $row.Last_Boot_Date = Get-Date $lastboot.lastbootuptime -Format "MM-dd-yyy"
            #get last patch date
            $lastpatch = Get-WmiObject -ComputerName $row.Name -Class Win32_Quickfixengineering -Credential $c| select @{Name="InstalledOn";Expression={$_.InstalledOn -as [datetime]}},InstalledBy | Sort-Object -Property Installedon | select-object -property installedon -last 1
            $row.Last_Patch_Date = Get-Date $lastpatch.InstalledOn -Format "MM-dd-yyy"
        
        }
          Catch {
            #$_ is the error object
            Write-Warning "Failed to get OperatingSystem information from $row.Name. $($_.Exception.Message)"
          }    

          If($drive -ne $null) {

            $row.OS_Drive_Free_Space = [math]::Round($drive.FreeSpace/1GB,2)

          }

        If($SCCMClient -ne $null)
        {
              # get the state of the sccm service. This should always return as it is checking servers which an sccm client version was found
              
            try {  

            $row.SCCM_Agent_State = $(Get-WMIObject -Credential $c -ComputerName $row.Name -ErrorAction Stop  -Class Win32_Service -Filter "Name='CcmExec'").State
            
            #should add in a stop/start sequence for the service as proactive action    
            $row.Validation_Results = "SCCM Client Version " + $SCCMClient   
            $row.Error_Message = "None. Client version found."      

            } catch {$row.Error_Message = $_ }

        }
        Else
        {
         # needs improvement. should take eror message into account   
         $row.Validation_Results = "SCCM Client Version Not Found."  
                  
        }
    }
   
     Write-Host "Writing data for $server to $filename"
              
              $row | Export-Csv -Append -Path "$outpath\$filename" -NoTypeInformation                  

    }

# create the results CSV file. should be in a try catch block

# $Out | Export-Csv -Append -Path "$env:HOMEPATH\desktop\$filename" -NoTypeInf
