function Measure-FunctionTime {
    param (
        [ScriptBlock]$ScriptBlock
    )

    $result = Measure-Command -Expression $ScriptBlock

    Write-Output "Execution time: $($result.TotalMilliseconds) milliseconds"
}

# Usage
Measure-FunctionTime -ScriptBlock {
    #Copy function code below no need to call it in here

}