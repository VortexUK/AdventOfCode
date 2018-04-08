$InputPath = "$((Get-Location).Path)\input.txt"
$InputContent = Get-Content -Path $InputPath

function get-part1($InputContent)
{
    $sum = 0
    foreach($line in $InputContent)
    {
        $maxandmin = [int[]]($line -split '\s+') | Measure-Object -Minimum -Maximum
        $sum += $maxandmin.Maximum - $maxandmin.Minimum
    }
    Write-Output -InputObject $sum
}

function get-part2($InputContent)
{
    $sum = 0
    foreach($line in $InputContent)
    {
        $int_array = [int[]]($line -split '\s+')
        for ($i = 0;$i -lt $int_array.count;$i++)
        {
            for ($j = 0;$j -lt $int_array.count;$j++)
            {
                if ($i -ne $j)
                {
                    if ($int_array[$i] % $int_array[$j] -eq 0)
                    {
                        $sum+= $int_array[$i] / $int_array[$j]
                    }
                }
            }
        }
    }
    Write-Output -InputObject $sum
}

Get-Part1 -InputContent $InputContent
Get-Part2 -InputContent $InputContent