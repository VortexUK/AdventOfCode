$numbers = [System.int64[]](Get-Content -Path D:\git\AdventOfCode\2018\Day1\input.txt)
#region Part 1
[System.Int32]$Part1 = ($numbers | Measure-Object -sum).sum
#endregion
#region Part 2
$numberfound = $false
$currentsum = 0
$numberhash = @{}
while (!$Numberfound)
{
    :frequencyloop foreach ($number in $numbers)
    {
        $currentsum += $number
        $numberhash.$currentsum += 1
        if ($numberhash.$currentsum -gt 1)
        {
            $numberfound = $true
            $Part2 = $currentsum
            break frequencyloop
            
        }
    }
}
#endregion
Write-Host "Answer to Part 1: $Part1"
Write-Host "Answer to Part 2: $Part2"