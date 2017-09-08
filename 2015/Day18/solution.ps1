$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day18\input.txt"
Function Format-Inputs ($inputs)
{
    $lights = @(0) * 102
    0..101 | % {$lights[$_] = @(0) *102}
    $countx = 0
    foreach ($line in $inputs)
    {
        $linesplit = $line -split '' | ? {$_ -match '.'}
        $county = 0
        foreach ($light in $linesplit)
        {
            switch ($light)
            {
                '#' {$lights[$countx+1][$county+1] = 1}
            }
            $county++
        }
        $countx++
    }
    return $lights
}
function Get-NextLightSetup ($lights,$part)
{
    $newlights = @(0) * 102
    0..101 | % {$newlights[$_] = @(0) *102}
    for ($x = 1; $x -lt 101; $x++)
    {
        for ($y = 1; $y -lt 101; $y++)
        {
            if ($part -eq '2' -and (($x -eq 1 -and $y -eq 1) -or ($x -eq 100 -and $y -eq 100) -or ($x -eq 1 -and $y -eq 100) -or ($x -eq 100 -and $y -eq 1)))
            {
                $newlights[$x][$y] = 1
            }
            else
            {
                $lightsum = ($lights[$x-1][($y-1)..($y+1)] + $lights[$x+1][($y-1)..($y+1)] + $lights[$x][$y-1] + $lights[$x][$y+1] | Measure -sum).Sum
                Switch ($lights[$x][$y])
                {
                    '0' 
                    {
                        if ($lightsum -eq 3)
                        {
                            $newlights[$x][$y] = 1
                        }
                        else
                        {
                            $newlights[$x][$y] = 0
                        }
                    }
                    '1' 
                    {
                        if ($lightsum -notin 2,3)
                        {
                            $newlights[$x][$y] = 0
                        }
                        else
                        {
                            $newlights[$x][$y] = 1
                        }
                    }
                }
            }
        }
    }
    return $newlights
}
$lights = Format-Inputs -inputs $inputs
function Get-Part1 ($lights)
{
    $currentlights = $lights
    for ($i = 0; $i -lt 100; $i++)
    {
        $i
        $currentlights = Get-NextLightSetup -lights $currentlights -part 1
    }
    $lightson = $currentlights | % {$_ | measure -sum | select -ExpandProperty sUM}  | measure -sum | select -ExpandProperty sum
    return $lightson
}
function Get-Part2 ($lights)
{
    $currentlights = $lights
    for ($i = 0; $i -lt 100; $i++)
    {
        $i
        $currentlights = Get-NextLightSetup -lights $currentlights -part 2
    }
    $lightson = $currentlights | % {$_ | measure -sum | select -ExpandProperty sUM}  | measure -sum | select -ExpandProperty sum
    return $lightson
}
Get-Part1 -lights $lights
Get-Part2 -lights $lights