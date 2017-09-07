$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day3\input.txt"
function Get-Part1 ($inputs)
{
    $Directions = $inputs -split ''
    $PresentCounts = @{}
    $SantaX = 0
    $SantaY = 0
    for ($i = 0; $i -lt ($Directions.Count); $i++)
    {
        $PresentCounts."$SantaX-$SantaY" += 1
        switch ($directions[$i])
        {
            '^' {$SantaY++}
            'v' {$SantaY--}
            '>' {$SantaX++}
            '<' {$SantaX--}
        }
    }
    $NumberOfHousesWithPresents = ($PresentCounts.GetEnumerator() | Measure).Count
    return $NumberOfHousesWithPresents
}
function Get-Part2 ($inputs)
{
    $Directions = $inputs -split ''
    $PresentCounts = @{}
    $SantaX = 0
    $SantaY = 0
    $RoboX = 0
    $RoboY = 0
    for ($i = 0; $i -lt ($Directions.Count); $i+=2)
    {
        $PresentCounts."$SantaX-$SantaY" += 1
        $PresentCounts."$RoboX-$RoboY" += 1
        switch ($directions[$i])
        {
            '^' {$SantaY++}
            'v' {$SantaY--}
            '>' {$SantaX++}
            '<' {$SantaX--}
        }
        switch ($directions[$i+1])
        {
            '^' {$RoboY++}
            'v' {$RoboY--}
            '>' {$RoboX++}
            '<' {$RoboX--}
        }
    }
    $NumberOfHousesWithPresents = ($PresentCounts.GetEnumerator() | Measure).Count
    return $NumberOfHousesWithPresents
}
Get-Part1 -inputs $inputs
Get-Part2 -inputs $inputs


