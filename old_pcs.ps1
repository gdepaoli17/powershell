
$logdate = Get-Date -format yyyyMMdd
$logfile = "c:\Temp\Expired_pcs - "+$logdate+".csv"
$DaysInactive = 90 
$time = (Get-Date).Adddays(-($DaysInactive))


# go backwards when drilling down
$searchOU = "<enter distinguished name"

# Get all AD computers with LastLogon less than our time
$grabpc = Get-ADComputer -SearchBase $searchOU -Filter {LastLogon -lt $time -and enabled -eq $true} -Properties LastLogon, description

 
# Output hostname and LastLogon into CSV
$grabpc | select-object Name,DistinguishedName, description, enabled,@{Name="Stamp"; Expression={[DateTime]::FromFileTime($_.LastLogon)}} | export-csv $logfile -notypeinformation
