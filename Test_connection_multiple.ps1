$filePath = "C:\temp\Pings.csv"

# Get pc's in OU 
$computerNames = Get-ADComputer -Filter * -SearchBase "<enter distinguished name" -SearchScope OneLevel | Select-Object -Property Name

# Define an empty array list to store the results
$results = New-Object System.Collections.ArrayList


# Loop through each computer object
$computerNames.ForEach({
    if(Test-Connection -ComputerName $_.Name -Quiet -Count 1){
        $result = [PSCustomObject]@{
            Name = $_.Name
            Status = "Online"
        }
        $results.Add($result) | Out-Null
    }else{
        $result = [PSCustomObject]@{
            Name = $_.Name
            Status = "Offline"
        }
        $results.Add($result) | Out-Null
    }
})

#Display the results array list grouped by status
$results | sort-object -property status | format-table -GroupBy status 

# Export to excel
$results | Export-Csv -Path $filePath