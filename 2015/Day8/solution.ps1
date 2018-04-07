$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day8\input.txt"
$escapes = @('\\\\(?!".)','\\"(?=.)','\\(x[a-z0-9]{2})')

function Get-Part1 ($inputs)
{
    $actualstrings = @()
    foreach ($string in $inputs)
    {
        $actualstrings += ((($string -replace $escapes[0],'a') -replace $escapes[1],'b') -replace $escapes[2],'c') -replace '^"|"$'
    }
    foreach ($string in $actualstrings)
    {
        $string.length
    }
    $stringsize = (($actualstrings -join '') -split '' | measure).Count
    $inputsize = (($inputs -join '') -split '' | measure).Count
    return ($inputsize - $stringsize)
}
function Get-Part2 ($inputs)
{
    $extendedstrings = @()
    foreach ($string in $inputs)
    {
        
        $extendedstrings += "`"$(($string -replace "\\","\\")-replace '"','\"')`""
    }
    $extendedsize = (($extendedstrings -join '') -split '' | measure).Count
    $inputsize = (($inputs -join '') -split '' | measure).Count
    return ($extendedsize - $inputsize)
}
Get-Part1 -inputs $inputs
Get-Part2 -inputs $inputs