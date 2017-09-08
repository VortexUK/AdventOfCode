$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day14\input.txt"
function Format-Inputs ($inputs)
{
    $Deer = @{}
    foreach ($inp in $inputs)
    {
        $Name,$speed,$speedtime,$resttime = $inp -replace '^([a-z]+) can fly ([0-9]+) km/s for ([0-9]+) seconds, but then must rest for ([0-9]+) seconds.', '$1,$2,$3,$4' -split ','
        $Deer.$Name = New-Object -TypeName PSObject -Property @{
            'Speed' = [int]$Speed
            'SpeedTime' = [int]$speedtime
            'RestTime' = [int]$resttime
            'Distance' = 0
            'Points' = 0
        }
    }
    return $Deer
}
function Test-DeerRunning ($CurrentTime,$DeerStats)
{
    $DeerRoundTime = $DeerStats.RestTime + $DeerStats.SpeedTime
    $PointinTime  = $CurrentTime % $DeerRoundTime 
    if ($PointinTime -le $DeerStats.SpeedTime -and $PointinTime -ne 0)
    {
        return $True
    }
    else
    {
        return $false
    }

}
$Deer = Format-Inputs -inputs $inputs
function Get-Part1 ($Deer)
{
    $Ticker = 0
    While ($Ticker -ne 2503)
    {
        $Ticker ++
        foreach ($DeerName in $Deer.GetEnumerator().Name)
        {
            #Test-DeerRunning -CurrentTime $Ticker -DeerStats $Deer.$DeerName
            if (Test-DeerRunning -CurrentTime $Ticker -DeerStats $Deer.$DeerName)
            {
                $Deer.$DeerName.Distance += $Deer.$DeerName.Speed
            }
        }
    }
    $WinningDistance = 0
    foreach ($DeerName in $Deer.GetEnumerator().Name)
    {
        if ($Deer.$DeerName.Distance -gt $WinningDistance)
        {
            $WinningDistance = $Deer.$DeerName.Distance
        }
    }
    return $WinningDistance
}
function Get-Part2 ($Deer)
{
    $Ticker = 0
    While ($Ticker -ne 2503)
    {
        $Ticker ++
        foreach ($DeerName in $Deer.GetEnumerator().Name)
        {
            #Test-DeerRunning -CurrentTime $Ticker -DeerStats $Deer.$DeerName
            if (Test-DeerRunning -CurrentTime $Ticker -DeerStats $Deer.$DeerName)
            {
                $Deer.$DeerName.Distance += $Deer.$DeerName.Speed
            }
        }
        $WinningDistanceinRound = 0
        foreach ($DeerName in $Deer.GetEnumerator().Name)
        {
            #Test-DeerRunning -CurrentTime $Ticker -DeerStats $Deer.$DeerName
            if ($Deer.$DeerName.Distance -gt $WinningDistanceinRound)
            {
                $WinningDistanceinRound = $Deer.$DeerName.Distance
            }
        }
        foreach ($DeerName in $Deer.GetEnumerator().Name)
        {
            if ($Deer.$DeerName.Distance -eq $WinningDistanceinRound)
            {
                $Deer.$DeerName.Points++
            }
        }
    }
    $WinningPoints = 0
    foreach ($DeerName in $Deer.GetEnumerator().Name)
    {
        if ($Deer.$DeerName.Points -gt $WinningPoints)
        {
            $WinningPoints = $Deer.$DeerName.Points
        }
    }
    return $WinningPoints
}
Get-Part1 -Deer $Deer
$Deer = Format-Inputs -inputs $inputs
Get-Part2 -Deer $Deer