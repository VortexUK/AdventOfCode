$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day5\input.txt"
$rule1 = "[aeiou].*[aeiou].*[aeiou]"
$rule2 = "([a-z])\1"
$rule3 = "ab|cd|pq|xy" 
$rule4 = "(..).*\1"
$rule5 = "(.).\1"
function Get-Part1 ($inputs)
{
    $Count = ($inputs | ? {$_ -notmatch $rule3 -and $_ -match $rule1 -and $_ -match $rule2} | Measure).Count
    return $Count
}
function Get-Part2 ($inputs)
{
    $Count = ($inputs | ? {$_ -match $rule4 -and $_ -match $rule5} | Measure).Count
    return $count
}
Get-Part1 -inputs $inputs
Get-Part2 -inputs $inputs