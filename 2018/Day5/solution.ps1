[System.String]$inp = Get-Content -Path D:\git\AdventOfCode\2018\Day5\input.txt
[System.Collections.ArrayList]$chararray = [String[]][char[]]$inp
#region Part 1
$part1start = get-date
[System.Boolean]$reactionsdone = $true
while ($reactionsdone)
{
    $reactionsdone = $false
    for ($i =0;$i -lt $chararray.count;$i++)
    {
        switch -CaseSensitive -Regex ($chararray[$i])
        {
            '[A-Z]' 
            {
                if ($Chararray[$i+1] -ceq $chararray[$i].ToLower())
                {
                    $null = $chararray.RemoveRange($i,2)
                    $reactionsdone = $true
                    $i = $i-2
                }
            }
            '[a-z]'
            {
                if ($Chararray[$i+1] -ceq $chararray[$i].ToUpper())
                {
                    $null = $chararray.RemoveRange($i,2)
                    $reactionsdone = $true
                    $i = $i -2
                }
            }
        }
    }
}
[System.Int32]$Part1 = $chararray.count
$part1end = get-date
#endregion
#region Part 2
$part2start = get-date
[System.String]$bestLetter = "a"
[System.Int32]$bestscore = 50000
foreach ($letter in (65..90|foreach-object{[char]$_}))
{
    [System.Collections.ArrayList]$chararray = [String[]][char[]]($inp -replace "$letter")
    $reactionsdone = $true
    while ($reactionsdone)
    {
        $reactionsdone = $false
        $count++
        for ($i =0;$i -lt $chararray.count;$i++)
        {
            switch -CaseSensitive -Regex ($chararray[$i])
            {
                '[A-Z]' 
                {
                    if ($Chararray[$i+1] -ceq $chararray[$i].ToLower())
                    {
                        $null = $chararray.RemoveRange($i,2)
                        $reactionsdone = $true
                        $i = $i-2
                    }
                }
                '[a-z]'
                {
                    if ($Chararray[$i+1] -ceq $chararray[$i].ToUpper())
                    {
                        $null = $chararray.RemoveRange($i,2)
                        $reactionsdone = $true
                        $i = $i -2
                    }
                }
            }
        }
    }
    if ($chararray.count -lt $bestscore)
    {
        $bestLetter = $letter
        $bestscore = $chararray.count
    }
}
[System.Int32]$Part2 = $bestscore
$part2end = get-date
#endregion
Write-Host -Object "Answer to Part 1: $Part1 (Took $((New-TimeSpan -Start $part1start -End $part1end).Milliseconds) Milliseconds)" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2 (Took $((New-TimeSpan -Start $part2start -End $part2end).Seconds) Seconds)" -ForegroundColor Yellow
