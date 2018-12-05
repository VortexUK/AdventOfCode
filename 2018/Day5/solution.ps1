$inp = gc D:\day5.txt
[System.Collections.ArrayList]$chararray = [String[]][char[]]$inp
$reactionsdone = $true
$count = 0
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
$Part1 = $chararray.count

$bestLetter = "a"
$bestscore = 50000
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
$Part2 = $bestscore
