$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day20\input.txt"
function Get-Part1 ($target)
{
    $houses = @(0) * ($Target/10)
    for ($i =1;$i -lt ($Target/10);$i++)
    {
        for ($j = $i; $j -lt  ($Target/10);$j+= $i)
        {
            $houses[$j] += $i * 10
        }
    }
    $besthouse = 0
    for ($i = ($Target/10); $i -ne 0 ;$i--)
    {
        if ($houses[$i] -ge $Target)
        {
            $besthouse = $i
        }
    }
    return $besthouse
}
function Get-Part2 ($target)
{
    $houses = @(0) * ($Target/10)
    for ($i =1;$i -lt ($Target/10);$i++)
    {
        $StopAt = ($Target/10)
        if ($i*50 -lt $StopAt)
        {
            $StopAt = $i * 50
        }
        for ($j = $i; $j -lt  $StopAt;$j+= $i)
        {
            $houses[$j] += $i * 11
        }
    }
    $besthouse = 0
    for ($i = ($Target/10); $i -ne 0 ;$i--)
    {
        if ($houses[$i] -ge $Target)
        {
            $besthouse = $i
        }
    }
    return $besthouse
}
Get-Part1 -target ([int]$inputs)
Get-Part2 -target ([int]$inputs)