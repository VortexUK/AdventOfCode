$start = get-date
[System.String[]]$inp = Get-Content -Path D:\git\AdventOfCode\2018\Day3\input.txt
[System.Collections.ArrayList]$formattedinput = $inp | Select-Object -Property @{N='Claim'; E = {[System.Int32](($_ -split ' ')[0] -replace '#')}},
                                @{N='XStart'; E = {[System.Int32]($_ -split ' |,')[2]}},
                                @{N='YStart'; E = {[System.Int32]($_ -split ' |,' -replace ':')[3]}},
                                @{N='XLength'; E = {[System.Int32]($_ -split ' |x' -replace ':')[3]}},
                                @{N='YLength'; E = {[System.Int32]($_ -split ' |x' -replace ':')[4]}}
#region Part 1
[System.Object[,]]$Fabric = New-Object -TypeName 'object[,]' -ArgumentList 1100,1100
foreach ($Claim in $FormattedInput)
{
    [System.Int32]$XEnd = $Claim.XStart + $Claim.XLength
    [System.Int32]$YEnd = $Claim.YStart + $Claim.YLength
    for ($x = $Claim.XStart; $x -lt $XEnd; $x++)
    {
        for ($y = $Claim.YStart;$y -lt $YEnd; $y++)
        {
            $Fabric[$x,$y] += 1
        }
    }
}
[System.Int32]$Part1 = ($Fabric | Where-Object -FilterScript {$_ -gt 1} | Measure-Object).Count
#endregion
#region Part 2
:fabricloop foreach ($Claim in $FormattedInput)
{
    [System.Int32]$XEnd = $Claim.XStart + $Claim.XLength
    [System.Int32]$YEnd = $Claim.YStart + $Claim.YLength
    [System.Boolean]$Overlapping = $false
    for ($x = $Claim.XStart; $x -lt $XEnd; $x++)
    {
        for ($y = $Claim.YStart;$y -lt $YEnd; $y++)
        {
            if ($Fabric[$x,$y] -gt 1)
            {
                $Overlapping = $true
                break fabricloop
            }
        }
    }
    if ($Overlapping -eq $false)
    {
        [System.Int32]$Part2 = $Claim.Claim
        break fabricloop
    }
}
#endregion
Write-Host -Object "Answer to Part 1: $Part1" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2" -ForegroundColor Yellow
$end = get-date
New-TimeSpan $start $end