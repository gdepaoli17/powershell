$rootFolder = "<enter root folder here>"
$description = "<enter description of the folder>"

new-psdrive -Name "Q" -PSProvider FileSystem -Root $rootFolder -Persist -Description $description
Remove-PSDrive -Name "Q"


