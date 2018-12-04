[System.int64[]]$Numbers = (Get-Content -Path D:\git\AdventOfCode\2018\Day1\input.txt)
#region Part 1
[System.Int32]$Part1 = ($Numbers | Measure-Object -sum).sum
#endregion
#region Part 2
[System.Boolean]$FrequencyFound = $false
[System.Int32]$CurrentSum = 0
[System.Collections.ArrayList]$Seen = @()
while (!$FrequencyFound)
{
    :frequencyloop foreach ($Number in $Numbers)
    {
        $currentsum += $number
        #$numberhash.$currentsum += 1
        if ($CurrentSum -in $Seen)
        {
            $FrequencyFound = $true
            $Part2 = $currentsum
            break frequencyloop
        }
        $null = $Seen.Add($CurrentSum)
    }
}
#endregion
Write-Host -Object "Answer to Part 1: $Part1" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2" -ForegroundColor Yellow