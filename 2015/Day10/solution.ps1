$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day10\input.txt"
function Get-JCNumber ($string)
{
    $inpsplit = $string -split '' | ? {$_ -match '.'}
    $newstring = ''
    $currentnum = $inpsplit[0]
    $count = 0
    for ($i = 0; $i -lt $inpsplit.Length;$i++)
    {
        if ($currentnum -eq $inpsplit[$i])
        {
            $count++
        }
        else
        {
            $newstring += "$count$currentnum"
            $count = 1
            if ($i -le $inpsplit.Length)
            {
                $currentnum = $inpsplit[$i]
            }
        }
        if($i -eq $inpsplit.Length-1)
        {
            $newstring += "$count$currentnum"
        }
    }
    return $newstring
}
function Get-Part1 ($string)
{
    for ($i = 0; $i -lt 40;$i++)
    {
        $string = Get-JCNumber -string $string
    }
    return $string.Length
}
function Get-Part2 ($string)
{
    for ($i = 0; $i -lt 50;$i++)
    {
        $i
        $string = Get-JCNumber -string $string
    }
    return $string.Length
}
Get-Part1 -string $inputs
Get-Part2 -string $inputs