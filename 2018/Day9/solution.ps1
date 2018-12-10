[System.Int32]$PlayerCount,[System.Int32]$MarbleCount = (Get-Content -Path D:\git\AdventOfCode\2018\Day9\input.txt) -split '\s+' | Where-Object {$_ -match '^[0-9]+$'}
#[System.Int32]$PlayerCount,[System.Int32]$MarbleCount =13,7999
$playerscores = @{}
function Get-MarbleWinner($PlayerCount,$MarbleCount)
{
    [System.Collections.ArrayList]$MarbleCircle = @(0, 2, 1, 3)
    $CurrentPlayer = 3
    $MarblePosition = 3
    for ($CurrentMarble = 4; $CurrentMarble -lt $MarbleCount;$CurrentMarble++)
    {
        if ((($CurrentMarble-1) % ($PlayerCount)) -eq 0)
        {
            $CurrentPlayer = 1
        }
        else
        {
            $CurrentPlayer ++
        }
        if ( $CurrentMarble % 23 -eq 0)
        {
            if ($MarblePosition -7 -lt 0)
            {
                $MarblePosition = $MarbleCircle.Count - (7-$MarblePosition)
            }
            else
            {
                $MarblePosition -= 7
            }
            $Playerscores[$CurrentPlayer]+= $CurrentMarble
            $Playerscores[$CurrentPlayer]+= $MarbleCircle[$MArblePosition]
            $MarbleCircle.RemoveAt($MarblePosition)
        }
        else
        {
            $MarblePosition += 2
            if ($MarblePosition -gt ($MarbleCircle.Count))
            {
                $MarblePosition = $MarblePosition % ($MarbleCircle.Count)
            }
            $MarbleCircle.Insert($MarblePosition,$CurrentMarble)
        }
        if ($CurrentMarble % 50000 -eq 0)
        {
            Write-Host $CurrentMarble
        }
    }
    return ($playerscores.GetEnumerator() | sort value -Descending)[0].Value
}
#region Part 1
[System.DateTime]$part1start = Get-date
$Part1 = Get-MarbleWinner -PlayerCount $PlayerCount -MarbleCount $MarbleCount
[System.DateTime]$Part1End = Get-Date
#endregion
#region Part 2
[System.DateTime]$Part2Start = Get-date
$Part1 = Get-MarbleWinner -PlayerCount $PlayerCount -MarbleCount ($MarbleCount * 100)
[System.DateTime]$Part2End = Get-Date
#endregion
Write-Host -Object "Answer to Part 1: $Part1 (Took $((New-TimeSpan -Start $part1start -End $Part1End).Milliseconds) Milliseconds)" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2 (Took $((New-TimeSpan -Start $Part2Start -End $part2end).Milliseconds) Milliseconds)" -ForegroundColor Yellow