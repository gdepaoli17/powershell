# # Get user's full name
# Clear-Host
# $getName = Read-Host -Prompt "Please enter the new hires full name"
# *** Full Name can be tricky with so many employees .. Per Mike G better to use HRID **

$ou = "<enter distinguished name>"

# Get user's AD info
$user = Get-ADUser -Filter {Name -like $getName} -Properties *

# Get Computer info 
$getPC = Get-ADComputer -Filter "Description -like `"*$($getUser.SamAccountName)*`"" -SearchBase $ou -SearchScope OneLevel -Properties *

function Execute-SQLQuery {
    # search = what you are searching for in query
    
    param (
    [string]$Server,
    [string]$Database,
    [string]$Table,
    [string]$FirstName,
    [string]$LastName,
    [string]$QueryType
    )

    # SQL query
    $locationQuery = @"
    SELECT 'location'
    FROM [$Database].[dbo].[$Table]
    WHERE [firstname] = '$FirstName' AND [lastname] = '$LastName'
"@
    

    $csAgentIDQuery = @"
SELECT 'ss_LogonID'
FROM [$Database].[dbo].[$Table]
WHERE [firstname] = '$FirstName' AND [lastname] = '$LastName'
"@

    # Create a Connection
    $sqlConnection = New-Object System.Data.SqlClient.SqlConnection
    $sqlConnection.ConnectionString = "Server ='$Server';database='$Database;trusted_connection=true;"
    $sqlConnection.Open()
    
    # Create your command
    $sqlCommand = New-Object System.Data.SqlClient.SqlCommand
    $sqlCommand.Connection = $sqlConnection
    
    if($QueryType -eq "location"){
        $sqlCommand.CommandText = $locationQuery
    }else{
        $sqlCommand.CommandText = $csAgentIDQuery
    }
    
    
    # create your data adapter
    $dataAdapter = New-Object System.Data.SqlClient.SqlDataAdapter $sqlCommand
    
    # Create your dataset
    $data = New-Object System.Data.DataSet
    $dataAdapter.Fill($data) | Out-Null
    
    # return DataTable
    return $data.Tables
    
}


# build user data 
$userData = [PSCustomObject]@{
    FullName = $getUser.Name
    UserName = $getUser.SamAccountName
    EmailAddress = $getUser.EmailAddress
    PhoneNumber = $getUser.telephoneNumber
    PC = $getPC.CN
    AS400 = $getUser.as400UserID
    AS400Password = $getUser.as400UserID
    HRID = $getUser.HRID
    # Location = $location
}


write-host $userData