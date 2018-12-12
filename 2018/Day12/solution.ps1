[System.String[]]$Inp = Get-Content -Path D:\git\AdventOfCode\2018\Day12\input.txt | Where-Object {$_ -match '.'}
[System.Collections.ArrayList]$state = ('...' + (($Inp[0]) -replace '.+:\s') + '...') -split '' | Where-Object {$_ -match '.'}
[System.Collections.ArrayList]$PositiveMatches = $($inp[1..($inp.Length-1)] | Where-Object {$_ -match '#$'}) -replace '\s.+'
[System.Int32]$ZeroIndex = 3
function Get-GenerationSum ($State,$ZeroIndex)
{
    $adjustment = -$ZeroIndex
    $sum = 0
    for ($i = 0; $i -lt $state.count; $i++)
    {
        if ($state[$i] -eq '#')
        {
            $sum += ($i + $adjustment)
        }
    }
    return $sum
}
function Get-PlantSum ([System.Collections.ArrayList]$State,$PositiveRules,$GenerationCount, $ZeroIndex)
{
    [System.Boolean]$Extrapolate = $false
    [System.Collections.ArrayList]$Last10Generations = @(0,0,0,0,0,0,0,0,0)
    [System.Int64]$PreviousSum = 0
    [System.Int64]$CurrentSum = 0
    for ($generation = 0; $generation -lt $GenerationCount; $generation++)
    {
        $PreviousSum = $CurrentSum
        $newstate = @('.','.')
        while (($State[0..3] -join '') -eq '....')
        {
            $null = $state.RemoveAt(0)
            $ZeroIndex--
        }
        foreach ($location in (2..(($state.count)-3)))
        {
            $window = ($State[($location-2)..($location+2)] -join '')
            if ($window -in $PositiveRules)
            {
                $newstate += '#'
            }
            elseif ($window -in $NegativeRules)
            {
                $newstate += '.'
            }
            else
            {
                $newstate += '.'
            }
        
        }
        $newstate += @('.','.')
        if ('#' -eq $newstate[($newstate.count -3)])
        {
            $newstate += @('.')
        }
        [System.Collections.ArrayList]$state = $newstate
        $CurrentSum = Get-GenerationSum -State $State -ZeroIndex $ZeroIndex
        $null = $Last10Generations.Add(($CurrentSum-$PreviousSum))
        if (($Last10Generations | Measure-Object).Count -gt 10)
        {
            $null = $Last10Generations.RemoveAt(0)
        }
        $Stats = $Last10Generations | Measure-Object -Minimum -Maximum
        if ($Stats.Minimum -eq $Stats.Maximum)
        {
            $CurrentGenNum = $Generation
            $Diff = $Last10Generations[0]
            $Generation = $GenerationCount # Exit out of loop
            $Extrapolate = $true
        }
    }
    if ($Extrapolate -eq $false)
    {
        $Sum = Get-GenerationSum -State $State -ZeroIndex $ZeroIndex
    }
    else
    {
        $Sum = (Get-GenerationSum -State $State -ZeroIndex $ZeroIndex) + (($GenerationCount - $CurrentGenNum-1) * $Diff)
    }
    return $sum
}
#region Part 1
[System.DateTime]$part1start = Get-date
[System.Int32]$Part1 = Get-PlantSum -State $State -PositiveRules $PositiveMatches -GenerationCount 20 -ZeroIndex $ZeroIndex
[System.DateTime]$Part1End = Get-Date
#endregion
#region Part 2
[System.DateTime]$Part2Start = Get-date
[System.Int64]$Part2 = Get-PlantSum -State $State -PositiveRules $PositiveMatches -GenerationCount 50000000000 -ZeroIndex $ZeroIndex
[System.DateTime]$Part2End = Get-Date
#endregion
Write-Host -Object "Answer to Part 1: $Part1 (Took $((New-TimeSpan -Start $part1start -End $Part1End).TotalMilliseconds) Milliseconds)" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2 (Took $((New-TimeSpan -Start $Part2Start -End $part2end).TotalSeconds) Seconds)" -ForegroundColor Yellow