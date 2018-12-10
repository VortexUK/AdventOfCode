[System.Int32[]]$inp = (Get-Content -Path D:\git\AdventOfCode\2018\Day8\input.txt) -split '\s+'
#region Part 1
[System.DateTime]$part1start = Get-date
function Get-ChildNodeSum ($Array, $Index=0)
{
    [System.Int32]$Childnodes = $Array[$index]
    [System.Int32]$MetaDataCount = $Array[$index+1]
    [System.Collections.Hashtable]$Result = @{
        'Index' = $index+2
        'Sum' = 0
    }
    for ($i = 0; $i -lt $ChildNodes; $i++)
    {
        [System.Collections.HashTable]$child = Get-ChildNodeSum -Array $Array -Index $Result.Index]
        $Result.Index = $child.index
        $Result.Sum += $child.sum
    }
    for ($i = 0; $i -lt $MetaDataCount; $i++)
    {
        $Result.Sum += $Array[$Result.index]
        $Result.index += 1
    }
    return $result
}
[System.Int32]$Part1 = (Get-ChildNodeSum -Array $inp -Index 0).Sum
[System.DateTime]$Part1End = Get-Date
#endregion
#region Part 2
[System.DateTime]$Part2Start = Get-date
function Get-ChildNodeSumWeird ($Array, $Index = 0)
{
    [System.Int32]$Childnodes = $Array[$index]
    [System.Int32]$MetaDataCount = $Array[$index+1]
    [System.Collections.Hashtable]$Result = @{
        'Index' = $index +2
        'Sum' = 0
    }
    if ($ChildNodes -eq 0)
    {
        for ($i = 0; $i -lt $MetaDataCount; $i++)
        {
            $Result.Sum += $Array[$Result.index]
            $Result.index += 1
        }
    }
    else
    {
        [System.Collections.HashTable]$Children = @{}
        for ($i = 1; $i -le $ChildNodes; $i++)
        {
            [System.Collections.HashTable]$children[$i] = Get-ChildNodeSumWeird -Array $Array -Index ($Result.Index)]
            $Result.Index = $children[$i].index
        }
        for ($i = 0; $i -lt $MetaDataCount; $i++)
        {
            if ($Childnodes -ge ($Array[$Result.Index]) -and $Array[($Result.Index)] -ne 0)
            {
                $Result.Sum += $Children[(($Array[$Result.index]))].Sum
            }
            $Result.index += 1
        }
    }
    #Write-Host $result.sum
    return $result
}
[System.Int32]$Part2 = (Get-ChildNodeSumWeird -Array $inp).Sum
[System.DateTime]$Part2End = Get-Date
#endregion
Write-Host -Object "Answer to Part 1: $Part1 (Took $((New-TimeSpan -Start $part1start -End $Part1End).Milliseconds) Milliseconds)" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2 (Took $((New-TimeSpan -Start $Part2Start -End $part2end).Milliseconds) Milliseconds)" -ForegroundColor Yellow