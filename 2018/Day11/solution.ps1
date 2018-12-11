[System.Int32]$SerialNumber = Get-Content -Path D:\git\AdventOfCode\2018\Day11\input.txt
#$SerialNumber = 18
function Get-PowerLevel ($X, $Y, $SerialNumber)
{
    $RackID = $X + 10
    $PowerLevel = [System.Int32]([System.String]((($Y * $RackID) + $SerialNumber) * $RackID) -replace '.*(.)..','$1') -5
    return $PowerLevel
}
function New-PowerMap ($Size=300)
{
    [System.Collections.ArrayList]$PowerMap = 0..$Size
    0..300| % {$PowerMap[$_] = 0..$Size}
    for ($x =0; $x -lt $Size; $x++)
    {
        for ($y = 0; $y -lt $Size; $y++)
        {
            $PowerMap[$x][$y] = Get-PowerLevel -X $X -Y $y -SerialNumber $SerialNumber
        }
    }
    return $PowerMap
}
$PowerMap = New-PowerMap
$Scriptblock = {
    Param ($WindowSize)
    function Get-PowerLevelSum ($PowerMap, $X, $Y, $Windowsize)
    {
        $sum = 0
        for ($i = 0; $i -lt $windowSize;$i++)
        {
            #$sum+= ($PowerMap[$x+$i][($y)..($y+($windowsize-1))] | Measure-Object -sum).Sum
            for ($j  = 0; $j -lt $windowsize; $j++)
            {
                $sum += $PowerMap[$x+$i][$y+$j]
            }
        }
        return $sum
    }
    $Result = @{
        PowerLevel = 0
        BestXY = ""
    }
    for ($x =0; $x -lt (300-$WindowSize); $x++)
    {
        
        for ($y = 0; $y -lt (300-$windowsize); $y++)
        {
            $sum = Get-PowerLevelSum -PowerMap $Using:PowerMap -X $x -Y $y -Windowsize $windowsize
            if ($Sum -gt $Result.PowerLevel)
            {
                $Result.PowerLevel = $sum
                $Result.BestXY = "$X,$Y"
            }
        }
    }
    return $Result
}
$FullResults = @{}
$BestPower= 0
$BestXY = ""
$BestSize = 0
for ($windowsize = 3; $windowsize -lt 16;$windowsize++)
{
    $null = Start-Job -Name $WindowSize -ScriptBlock $Scriptblock -ArgumentList $windowsize
}
while ((Get-job -State Running | Measure-Object).Count -ne 0)
{
    $CompleteJobs = Get-Job -State Completed
    foreach ($Job in $CompleteJobs)
    {
        $Result = Receive-Job -Name $Job.Name
        $FullResults[($Job.Name)] = $Result
        if ($Result['PowerLevel'] -gt $BestPower)
        {
            $BestPower = $Result['PowerLevel']
            $BestXY = $Result['BestXY']
            $BestSize = $Job.Name
        }
        Write-host "At windowsize $($Job.Name) the best powerlevel was $($Result['PowerLevel'])"
        $Job | Remove-Job
    }
}
$Part1 = $($FullResults['3']['BestXY'])
$Part2 = "${BestXY},${BestSize}"
Write-Host -Object "Answer to Part 1: $Part1" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2" -ForegroundColor Yellow
