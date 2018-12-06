[System.String[]]$inp = Get-Content -Path D:\git\AdventOfCode\2018\Day6\input.txt
$FormattedInput = $inp | Select-Object -Property @{N='X';E = {[System.Int32]($_ -split ', ')[0].Trim()}},@{N='Y';E = {[System.Int32]($_ -split ', ')[1].Trim()}}
$XStats = $FormattedInput.X | Measure-Object -Minimum -Maximum
$YStats = $FormattedInput.Y | Measure-Object -Minimum -Maximum
[System.Collections.ArrayList]$AdjustedInputs = @()
foreach ($coordinate in $FormattedInput)
{
    $Coordinate.X = $coordinate.X - $XStats.Minimum
    $Coordinate.Y = $coordinate.Y - $YStats.Minimum
    $null = $AdjustedInputs.Add($coordinate)
}
function Get-ManhattanDistance($coordinate1,$coordinate2)
{
    return ([System.Math]::Abs($coordinate1.X - $coordinate2.X) + [System.Math]::Abs($coordinate1.y - $coordinate2.y))
}
$Grid = New-Object -TypeName Object[,] -ArgumentList ($XStats.Maximum- $Xstats.Minimum),($YStats.Maximum- $Ystats.Minimum)
#region Part 1
for($X=0;$x -lt ($XStats.Maximum- $Xstats.Minimum); $x++)
{
    for($Y=0;
}
#endregion
#region Part 2
#endregion
Write-Host -Object "Answer to Part 1: $Part1" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2" -ForegroundColor Yellow
118, 274