$inp = Get-Content -Path D:\git\AdventOfCode\2018\Day3\input.txt
$formattedinput = $inp | Select-Object -Property @{N='Claim'; E = {[System.Int32](($_ -split ' ')[0] -replace '#')}},
                                @{N='XStart'; E = {[System.Int32]($_ -split ' |,')[2]}},
                                @{N='YStart'; E = {[System.Int32]($_ -split ' |,' -replace ':')[3]}},
                                @{N='XLength'; E = {[System.Int32]($_ -split ' |x' -replace ':')[3]}},
                                @{N='YLength'; E = {[System.Int32]($_ -split ' |x' -replace ':')[4]}}
#region Part 1
$Fabric = New-Object 'object[,]' 1100,1100
foreach ($claim in $formattedinput)
{
    $xend = $claim.xstart + $claim.xlength
    $yend = $claim.ystart + $claim.ylength
    for ($x = $claim.xstart; $x -lt $xend; $x++)
    {
        for ($y = $claim.ystart;$y -lt $yend; $y++)
        {
            $Fabric[$x,$y] += 1
        }
    }
}
$Part1 = ($Fabric2 | Where-Object -FilterScript {$_ -gt 1} | Measure-Object).Count
#endregion
#region Part 2
foreach ($claim in $formattedinput)
{
    $xend = $claim.xstart + $claim.xlength
    $yend = $claim.ystart + $claim.ylength
    $Overlapping = $false
    for ($x = $claim.xstart; $x -lt $xend; $x++)
    {
        for ($y = $claim.ystart;$y -lt $yend; $y++)
        {
            if ($Fabric2[$x,$y] -gt 1)
            {
                $Overlapping = $true
            }
        }
    }
    if ($Overlapping -eq $false)
    {
        $Part2 = $Claim.Claim
    }
}
#endregion
Write-Host "Answer to Part 1: $Part1"
Write-Host "Answer to Part 2: $Part2"