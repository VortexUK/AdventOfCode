$inp = Get-Content -Path D:\git\AdventOfCode\2018\Day2\input.txt
#region Part 1
$2count = 0
$3count = 0
foreach ($string in $inp)
{
    $lettercounts = $string -split '' | ? {$_ -match '.'} |Group-Object
    if (($lettercounts | Where-Object -Property Count -eq 2 | Measure-Object).Count -gt 0)
    {
        $2count++
    }
    if (($lettercounts | Where-Object -Property Count -eq 3 | Measure-Object).Count -gt 0)
    {
        $3count++
    }
}
$Part1 = $2count * $3count
#endregion
#region Part 2
$stringlength = $formattedlist[0].length
:mainloop foreach ($sortedstring in $inp)
{
    :testloop foreach ($teststring in ($inp | Where-object {$_ -ne $sortedstring}))
    {
        $diffcount = 0
        $diffletters = ""
        for ($i = 0; $i -lt $stringlength; $i++)
        {
            if ($sortedstring[$i] -ne $teststring[$i])
            {
                $diffcount += 1
                $index = $i
            }
        }
        if ($diffcount -eq 1)
        {
            [System.Collections.ArrayList]$letters = $sortedstring -split '' | Where {$_ -match '.'}
            $null = $letters.RemoveAt($index)
            $Part2 = $Letters -join ''
            break mainloop
        }
    }
}

#endregion
Write-Host "Answer to Part 1: $Part1"
Write-Host "Answer to Part 2: $Part2"