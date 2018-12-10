[System.String[]]$inp = Get-Content -Path D:\git\AdventOfCode\2018\Day10\input.txt | ForEach-Object {($_ -replace '[^0-9\-]',' ').Trim()}
[System.Collections.ArrayList]$PointSet = $inp | Select-Object -Property @{N='X';E={[System.Int32]($_ -split '\s+')[0]}},@{N='Y';E={[System.Int32]($_ -split '\s+')[1]}},@{N='MoveX';E={[System.Int32]($_ -split '\s+')[2]}},@{N='MoveY';E={[System.Int32]($_ -split '\s+')[3]}}

function Move-Points ($PointSet)
{
    foreach ($Point in $PointSet)
    {
        $Point.X += $Point.MoveX
        $Point.Y += $Point.MoveY
    }
    return $PointSet
}
function Move-PointsReverse ($PointSet)
{
    foreach ($Point in $PointSet)
    {
        $Point.X -= $Point.MoveX
        $Point.Y -= $Point.MoveY
    }
    return $PointSet
}
[System.Collections.ArrayList]$Boundary = $PointSet | Measure-Object -Property X,Y -Maximum -Minimum | Select-Object Maximum,Minimum
#region Part 1
[System.DateTime]$Part1Start = get-date
[System.Boolean]$NotMostCompact = $true
[System.Int32]$Seconds = 0
while ($NotMostCompact)
{
    $TempPointSet = Move-Points -PointSet $PointSet
    $NewBoundary = $TempPointSet | Measure-Object -Property X,Y -Maximum -Minimum | Select-Object Maximum,Minimum
    if (($Boundary[0].Maximum - $Boundary[0].Minimum) -gt ($NewBoundary[0].Maximum - $NewBoundary[0].Minimum) -or ($Boundary[1].Maximum - $Boundary[1].Minimum) -gt ($NewBoundary[1].Maximum - $NewBoundary[1].Minimum))
    {
        $Boundary = $NewBoundary
        $PointSet = $TempPointSet
        $Seconds++
    }
    else
    {
        $NotMostCompact = $false
        # My answer (may not be true of all answers) was the one before the 'most compact' solution.
        $PointSet = Move-PointsReverse -PointSet $PointSet
    }
}
[System.String[]]$FinalPoints = $PointSet | % {"$($_.X)-$($_.Y)"}
[System.String[]]$Part1 = @()
for ($y=$Boundary[1].Minimum; $y -le $Boundary[1].Maximum;$y++)
{
    $Line = ""
    for ($x=$Boundary[0].Minimum; $x -le $Boundary[0].Maximum;$x++)
    {
        if ("$x-$y" -in $FinalPoints)
        {
            $Line+= "#"
        }
        else
        {
            $Line += "."
        }
    }
    $Part1 += $Line

}
[System.DateTime]$Part1End = get-date
#endregion
#region Part 2
[System.DateTime]$Part2Start = get-date
[System.Int32]$Part2 = $Seconds
[System.DateTime]$Part2End = get-date
#endregion
Write-Host -Object "Answer to Part 1:`r`n`r`n$($Part1 -join "`r`n") `r`n`r`n(Took $((New-TimeSpan -Start $part1start -End $part1end).TotalSeconds) Seconds)" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2 (Took $((New-TimeSpan -Start $part2start -End $part2end).TotalMilliseconds) Milliseconds)" -ForegroundColor Yellow
