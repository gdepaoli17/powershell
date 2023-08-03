# random password genarator
function New-RandomPassword(){
    $length = 20
    $characters = "1234567890!@#$%^&*()_+-=,./<>?;':\|`~zxcvbnmsdfghjklqwertyuiopZXCVBNMASDFGHJKLQWERTYUIOP"
    $random = 1..$length | ForEach-Object{Get-Random -Maximum $characters.Length}
    $Private:ofs=""
    return [string]$characters[$random]
}


$path = "C:\Users\gino.depaoli\Downloads\BeyondTrust TX.xlsx"

# import the excel sheet 
$data = Import-Excel -Path $path

# iterate through the rows
$data | ForEach-Object {$_.NewPassword = New-RandomPassword}


$data | Export-Excel -Path "C:\temp\PasswordUpdate.xlsx" -show -AutoSize -AutoFilter -FreezeTopRowFirstColumn