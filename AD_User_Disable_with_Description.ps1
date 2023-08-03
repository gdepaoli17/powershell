# Get users + Disable accounts + add disabled date to description
$ou = "<enter distinguished name"
$date = Get-Date -Format "MM/dd/yyyy"
$description = "Disabled on " + $date
# Write-Host $description

$facilities_Temps = Get-ADUser -Filter {Title -eq "Facilities Temp"} -SearchBase $ou -Properties Title | Sort-Object -Property Name

$facilities_Temps.foreach{
    Disable-ADAccount -Identity $_
    Set-ADUser -Identity $_ -Description $description
    
}
