[System.String[]]$inp = Get-Content -Path D:\git\AdventOfCode\2018\Day2\input.txt
#region Part 1
[System.Int32]$2Count = 0
[System.Int32]$3Count = 0
foreach ($String in $inp)
{
    $LetterCounts = $String.ToCharArray() | Group-Object
    if (($LetterCounts | Where-Object -Property Count -eq 2 | Measure-Object).Count -gt 0)
    {
        $2count++
    }
    if (($LetterCounts | Where-Object -Property Count -eq 3 | Measure-Object).Count -gt 0)
    {
        $3count++
    }
}
[System.Int32]$Part1 = $2count * $3count
#endregion
#region Part 2
[System.Int32]$StringLength = $formattedlist[0].length
:mainloop foreach ($string in $inp)
{
    :testloop foreach ($TestString in ($inp | Where-object {$_ -ne $string}))
    {
        [System.Int32]$DiffCount = 0
        for ($i = 0; $i -lt $StringLength; $i++)
        {
            if ($string[$i] -ne $teststring[$i])
            {
                $DiffCount += 1
                $index = $i
            }
        }
        if ($DiffCount -eq 1)
        {
            [System.Collections.ArrayList]$Letters = $string.ToCharArray()
            $null = $Letters.RemoveAt($index)
            $Part2 = $Letters -join ''
            break mainloop
        }
    }
}

#endregion
Write-Host -Object "Answer to Part 1: $Part1" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2" -ForegroundColor Yellow