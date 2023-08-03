

$logdate = Get-Date -format yyyyMMdd
$logfile = "c:\Temp\Expired_Managed_Users - "+$logdate+".csv"
$DaysInactive = 180 
$time = (Get-Date).Adddays(-($DaysInactive))


# what goes here??? for TX PCS
$searchOU = "<enter distinguished name"

# Get all AD computers with LastLogon less than our time
$grabpc = Get-ADUser -SearchBase $searchOU -Filter {lastlogondate -lt $time -and enabled -eq $true} -Properties LastLogondate, description

 
# Output hostname and LastLogon into CSV
$grabpc | select-object Name,DistinguishedName, description, enabled,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.LastLogon)}} | export-csv $logfile -notypeinformation
