$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day2\input.txt"
function Get-Part1 ($inputs)
{
    $total = 0
    foreach ($present in $inputs)
    {
        [int[]]$presentsplit = [int[]]($present -split 'x') | sort
        $side1 = $presentsplit[0] * $presentsplit[1]
        $side2 = $presentsplit[0] * $presentsplit[2]
        $side3 = $presentsplit[1] * $presentsplit[2]
        $smallestside = $side1
        $total += ($side1 *2) + ($side2 *2) + ($side3 *2) +$smallestside
    }
    return $total
}
function Get-Part2 ($input)
{
    $totalribbon = 0
    foreach ($present in $inputs)
    {
        [int[]]$presentsplit = [int[]]($present -split 'x') | sort
        $volume = $presentsplit[0] * $presentsplit[1] * $presentsplit[2]
        $smallestperimeter = ($presentsplit[0] * 2) + ($presentsplit[1] * 2)
        $totalribbon += ($smallestperimeter + $volume)
    }
    return $totalribbon
}
Get-Part1 -inputs $inputs
Get-Part2 -inputs $inputs