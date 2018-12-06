[System.String[]]$inp = Get-Content -Path \\czxbenm1\d$\day6.txt
$FormattedInput = $inp | Select-Object -Property @{N='X';E = {[System.Int32]($_ -split ', ')[0].Trim()}},@{N='Y';E = {[System.Int32]($_ -split ', ')[1].Trim()}}
$XStats = $FormattedInput.X | Measure-Object -Minimum -Maximum
$YStats = $FormattedInput.Y | Measure-Object -Minimum -Maximum
[System.Collections.ArrayList]$AdjustedInputs = @()
$Count = 0
foreach ($coordinate in $FormattedInput)
{
    $Coordinate.X = $coordinate.X - $XStats.Minimum
    $Coordinate.Y = $coordinate.Y - $YStats.Minimum
    $Coordinate | Add-Member -MemberType NoteProperty -Name 'Index' -Value $Count
    $Coordinate | Add-Member -MemberType NoteProperty -Name 'TileCount' -Value 0
    $Count++
    $null = $AdjustedInputs.Add($coordinate)
}
function Get-ManhattanDistance($coordinate1,$coordinate2)
{
    return ([System.Math]::Abs($coordinate1.X - $coordinate2.X) + [System.Math]::Abs($coordinate1.y - $coordinate2.y))
}
$Grid = New-Object -TypeName 'Object[,]' -ArgumentList ($XStats.Maximum - $Xstats.Minimum),($YStats.Maximum - $Ystats.Minimum)
$Grid2 = New-Object -TypeName 'Object[,]' -ArgumentList ($XStats.Maximum - $Xstats.Minimum),($YStats.Maximum - $Ystats.Minimum)
for($X=0;$x -lt ($XStats.Maximum- $Xstats.Minimum); $x++)
{
    $x
    for($y=0;$y -lt ($YStats.Maximum- $Ystats.Minimum); $Y++)
    {
        $BestDistance = 1000
        $BestCoord = -2
        foreach ($Coord in $AdjustedInputs)
        {
            $Distance = Get-ManhattanDistance -coordinate1 @{'X' = $x; 'Y' = $y} -coordinate2 $Coord
            if ($Distance -eq $BestDistance)
            {
                $BestCoord = -1
            }
            if ($Distance -lt $BestDistance)
            {
                $BestDistance = $Distance
                $BestCoord = $Coord.Index
            }
            $Grid2[$x,$y]  += $Distance
        }
        $Grid[$x,$y] = $BestCoord
        
    }
}
#region Part 1

[System.Collections.ArrayList]$InfiniteCoords = @()
for ($x = 0; $x -lt ($XStats.Maximum - $Xstats.Minimum); $x++)
{
    $null = $InfiniteCoords.Add(($Grid[$x,0]))
    $null = $InfiniteCoords.Add(($Grid[$x,($YStats.Maximum - $Ystats.Minimum -1)]))
}
for ($y = 0; $y -lt ($YStats.Maximum - $Ystats.Minimum); $Y++)
{
    $null = $InfiniteCoords.Add(($Grid[0,$y]))
    $null = $InfiniteCoords.Add(($Grid[($XStats.Maximum - $Xstats.Minimum -1),$y]))
}
$InfiniteCoords = $InfiniteCoords | Select-Object -Unique
for ($i=0; $i -lt 50;$i++)
{
    $AdjustedInputs[$i].TileCount = $Grid | Where-Object -FilterScript {$_ -eq $i} | Measure-Object | Select-Object -ExpandProperty Count
}
$Part1 = $AdjustedInputs | Where-Object -Property Index -notin $InfiniteCoords | Sort-Object -Property TileCount -Descending | Select-Object -first 1 -ExpandProperty TileCount
#endregion

#region Part 2
$Part2 = $Grid2 | Where-Object -FilterScript {$_ -lt 10000} | Measure-Object | Select-Object -ExpandProperty Count
#endregion
Write-Host -Object "Answer to Part 1: $Part1" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2" -ForegroundColor Yellow
