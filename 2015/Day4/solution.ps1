$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day4\input.txt"
$md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$utf8 = new-object -TypeName System.Text.UTF8Encoding
function Get-Part1 ($inputs)
{
    $hashnotfound = $true
    $count = 0
    while ($hashnotfound)
    {
        $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes("$inputs$count")))
        if ($hash -match "^00-00-0")
        {
            $hashnotfound = $false
            return $count
        }
        $count++
    }
}
function Get-Part2 ($inputs)
{
    $hashnotfound = $true
    $count = 0
    while ($hashnotfound)
    {
        $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes("$inputs$count")))
        if ($hash -match "^00-00-00")
        {
            $hashnotfound = $false
            return $count
        }
        $count++
    }
}
Get-Part1 -inputs $inputs
Get-Part2 -inputs $inputs


