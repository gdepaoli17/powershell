$ou = "<enter distinguished name"

$city = "Houston"


$names = [System.Collections.ArrayList]@()
$names.AddRange(@("<add list of users here separated by comma's"))


$names.foreach(
    {
        Get-ADUser -Filter {Name -eq $_} -SearchBase $ou -Properties * | if(City -ne $city){Set-ADUser -City $city}
    }
)

# Get-ADUser -Filter {Name -eq $_}
# if(City -ne $city){Set-ADUser -City $city}

