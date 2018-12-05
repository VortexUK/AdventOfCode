[System.String]$inp = Get-Content -Path D:\git\AdventOfCode\2018\Day5\input.txt
[System.Collections.ArrayList]$chararray = [String[]][char[]]$inp
#region Part 1
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
                if ($Chararray[$i+1] -cmatch $chararray[$i].ToLower())
                {
                    $null = $chararray.RemoveRange($i,2)
                    $reactionsdone = $true
                    $i = $i-2
                }
            }
            '[a-z]'
            {
                if ($Chararray[$i+1] -cmatch $chararray[$i].ToUpper())
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
#endregion
#region Part 2
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
                    if ($Chararray[$i+1] -cmatch $chararray[$i].ToLower())
                    {
                        $null = $chararray.RemoveRange($i,2)
                        $reactionsdone = $true
                        $i = $i-2
                    }
                }
                '[a-z]'
                {
                    if ($Chararray[$i+1] -cmatch $chararray[$i].ToUpper())
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
#endregion
Write-Host -Object "Answer to Part 1: $Part1" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2" -ForegroundColor Yellow
