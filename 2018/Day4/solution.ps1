$inp = Get-Content -Path D:\git\AdventOfCode\2018\Day4\input.txt
# Add 1 hour to all times, which removes the annoyance of shifts starting on a 'different day'
$formattedinputpart1 = $inp | Select-Object -Property @{N="Date";E = {([System.DateTime](($_ -split '\]')[0] -replace '\[')).AddHours(1)}},
                                                @{N="Action"; E = {($_ -split '\]')[1].Trim()}} | Sort-Object -Property Date
$DaysOfLog = $formattedinputpart1.date.date | select -Unique
$GuardLog = @()
foreach ($Day in $DaysOfLog)
{
    $GuardLog += New-Object -TypeName PSObject -Property @{
        'Date' = $Day
        'Time' = New-Object -TypeName 'object[]' -ArgumentList 120
        'Guard' = ''
    }
}
foreach ($Day in $GuardLog)
{
    $DayLog = $formattedinputpart1 | Where-Object {$_.Date.Date -eq $Day.Date}
    $Day.Guard = ($DayLog[0].Action -split ' ')[1] -replace '#'
    $GuardState = -1 # -1 = Not on guard - # 0 On guard and awake - 1 on guard and asleep
    for($min =0; $min -lt 120; $min++)
    {
        $CurrentTime = $Day.Date.AddMinutes($Min)
        $LogItem = $DayLog | Where-object -Property Date -eq $CurrentTime
        if ($LogItem)
        {
            switch -regex ($LogItem.Action)
            {
                "Guard #"
                {
                    $GuardState = 0
                }
                "falls"
                {
                    $GuardState = 1
                }
                "wakes"
                {
                    $GuardState = 0
                }
            }
        }
        $Day.Time[$min] = $GuardState
    }
}
#region Part 1
$GuardShifts = $GuardLog | Group-Object -Property Guard
$WorstGuard = 0
$AsleepRecord = 0
foreach ($Guard in $Guardshifts)
{
    $MinutesAsleep = $Guard.group.time | Where-Object {$_ -eq 1} | measure -sum | select -expand sum
    if ($MinutesAsleep -gt $AsleepRecord)
    {
        $AsleepRecord = $MinutesAsleep
        $WorstGuard = $Guard.Name
    }
}
$WorstGuardShifts = ($GuardShifts | Where-Object -Property Name -eq $WorstGuard).Group
$WorstMinute = 0
$WorstScore = 0
for($min = 0; $min -lt 120; $min++)
{
    $AsleepMin = $WorstGuardShifts | ForEach-Object -Process {$_.time[$min] | Where-Object -FilterScript {$_ -ge 0}} | Measure-Object -sum | Select-Object -ExpandProperty sum
    if ($WorstScore -lt $Asleepmin)
    {
        $WorstMinute = $min - 60
        $WorstScore = $AsleepMin
    }
}
$Part1 = $WorstMinute * $WorstGuard
#endregion
#region Part 2
$WorstGuard = 0
$WorstMinute = 0
$WorstScore = 0
foreach ($GuardShift in $GuardShifts)
{
    $WorstGuardMinute = 0
    $WorstGuardScore = 0
    for($min = 0; $min -lt 120; $min++)
    {
        $AsleepMin = $GuardShift.Group | ForEach-Object -Process {$_.time[$min] | Where-Object -FilterScript {$_ -ge 0}} | Measure-Object -sum | Select-Object -ExpandProperty sum
        if ($WorstGuardScore -lt $Asleepmin)
        {
            $WorstGuardMinute = $min - 60
            $WorstGuardScore = $AsleepMin
        }
    }
    if ($WorstScore -lt $WorstGuardScore)
    {
        $Worstguard = $GuardShift.Name
        $WorstMinute = $WorstguardMinute
        $WorstScore = $WorstGuardScore
    }
}
$part2 = $WorstMinute * $WorstGuard
#endregion
Write-Host -Object "Answer to Part 1: $Part1" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2" -ForegroundColor Yellow