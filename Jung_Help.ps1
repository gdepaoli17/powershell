$path = "C:\Temp\21h2.xlsx"
$get_computers = get-adcomputer -filter 'operatingsystemversion -le "10.0 (19044)"' -Properties name,description,operatingsystemversion,lastlogondate | Select-Object name,description,operatingsystemversion,lastlogondate

# $get_computers | Export-Excel -Path $path

$all_pc_info = New-Object System.Collections.ArrayList
$get_computers.foreach({
    $host_info = [PSCustomObject]@{
        Name = $($_.Name)
        Description = $($_.description)
        OS = $($_.operatingsystemversion)
        LogInDate = $($_.lastlogondate)
    }
    $all_pc_info.add($host_info)
})

$all_pc_info | Export-Excel -Path $path

###########################################################################################################
