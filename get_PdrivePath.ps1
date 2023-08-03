$ou = "<enter distinguished name"
$refasdUsers = get-aduser -Filter * -SearchBase $ou -Properties Name, HomeDirectory | Sort-Object Name

$pdriveList = $refasdUsers.foreach({

    [PSCustomObject]@{
        Name = $_.Name
        Pdrive = $_.HomeDirectory
    }
})

$pdriveList
