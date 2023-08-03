# gets the TX Managed OU that is part of the GPO_Warehouse Accounts group..
$path = "c:\temp\SwitchusersWHS.xlsx"
$whsAccounts = Get-ADUser -Filter * -SearchBase "<enter distinguished name" -Properties description,Memberof,Enabled | Where-Object {$($_.Memberof) -contains "<enter distinguished name of the group"} | Sort-Object -Property Name

# grabs the list of members that are in the GPO_Managed Accounts - WHS Restriction Test which disables FastSwitchUser
# used to get the accounts in group that start with T 
$adGroup = Get-ADGroupMember -Identity "<enter distinguished name of the group name" | ForEach-Object {if($($_.Name) -like "T*"){$($_.Name)}}

# declare open arraylist 
$addToExeption = New-Object -TypeName System.Collections.ArrayList

# for each loop as a method that adds a PSCustomObject if the WHS Managed account in TX is not in the WHS restriction group then add to open array list with the Name + Description + Membership(for validation)
$whsAccounts.ForEach({
    if($($_.name) -notin $adGroup -and $($_.Enabled)){
        $user = [PSCustomObject]@{
            Name = $($_.Name)
            Description = $($_.description)
            # Membership = ($($_.Memberof) -join ',')

        }
        $addToExeption.add($user)
}})

$addToExeption | Export-Excel -Path $path

############################################################################################################

# getting the uptime for whs managed PCS
# get pc name from description of the txt file
$pcsPath = Get-Content -Path "C:\Users\gino.depaoli\Documents\pcs.txt"
# # loop through list and get uptime for each
$pcUptimes = New-Object -TypeName System.Collections.ArrayList

foreach($pc in $pcsPath){
    $pcObject = [PSCustomObject]@{
        Name = $pc
        Uptime = uptime $pc
    }
    $pcUptimes.add($pcObject)
}

$pcUptimes | Export-Excel -Path "c:\temp\WHSuptimes.xlsx"

