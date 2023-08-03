function New-RandomPassword(){
    $length = 20
    $characters = "1234567890!@#$%^&*()_+-=,./<>?;':\|`~zxcvbnmsdfghjklqwertyuiopZXCVBNMASDFGHJKLQWERTYUIOP"
    $random = 1..$length | ForEach-Object{Get-Random -Maximum $characters.Length}
    $Private:ofs=""
    return [string]$characters[$random]
}

New-RandomPassword