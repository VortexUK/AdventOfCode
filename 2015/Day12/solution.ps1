$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day12\input.txt"
$JSON = $Inputs | ConvertFrom-Json
function Do-Array ($array, $part)
{
    foreach ($item in $Array)
    {
        switch ($item.Gettype().Name)
        {
            'Int32' 
            {
                [int]$item
            }
            'Object[]'
            {
                Do-Array $item -part $part
            }
            'PSCustomObject'
            {
                Do-Object $item -part $part
            }
        }
    }
}
function Do-Object ($obj, $part)
{
    $nored = $true
    foreach ($Property in $Obj.PSObject.Properties.Name)
    {
        #write-host $obj.$Property -foreground red
        if ("red" -eq $obj.$Property -and $obj.$property.GetType().Name -ne 'Object[]' )
        {
            $nored = $false
        }
    }
    if ($nored -or $Part -eq 1)
    {
        foreach ($Property in $Obj.PSObject.Properties.Name)
        {
            Do-Array $obj.$Property -part $part
        }
    }
}
function Get-Part1 ($inputs)
{
    $answer = Do-Array -array $JSON -part 1 | measure -sum | select -ExpandProperty Sum
    return $answer
}
function Get-Part2 ($inputs)
{
    $answer = Do-Array -array $JSON -part 2 | measure -sum | select -ExpandProperty Sum
    return $answer
}
Get-Part1 -inputs $JSON
Get-Part2 -inputs $JSON