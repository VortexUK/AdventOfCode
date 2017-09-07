$inputs = Get-Content -Path "D:\git\AdventOfCode\2015\Day1\input.txt"
function Get-Part1 ($inputs)
{
    $numup = (($inputs -split '') | ? {$_ -match "\("}).Count
    $numdown = (($inputs -split '') | ? {$_ -match "\)"}).Count
    return $numup-$numdown
}
function Get-Part2 ($inputs)
{
    $inputsplit = $inputs -split ''
    $count = 1
    $floor = 0
    foreach ($i in $inputsplit)
    {
    
        switch ($i)
        {
            '(' {$floor++}
            ')' {$floor--}
        }
        if ($floor -eq '-1')
        {
            return $count
        }
        $count++
    }
}
Get-Part1 -inputs $inputs
Get-Part2 -inputs $inputs