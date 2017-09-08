$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day11\input.txt"
Function Get-ConsecMatcher
{
    $ConsecMatcher = (((0..25 | %{ $_+[int][char]'a' } | %{ ([char[]]@($_,($_+1),($_+2))) -join "" } | select -first 24)) | Where-Object {$_ -notmatch '[ilo]'}) -join '|'
    return $ConsecMatcher
}
function Add-ToPasswordArray ($CurrentPassword)
{
    $PWArray = $CurrentPassword.ToCharArray()
    $Length = $PWArray.Length
    for ($i = $Length-1;$i -ne 0; $i--)
    {
        if ($PWArray[$i] -ne 'z')
        {
            $PWArray[$i] = [char](1 + [int][char]$PWArray[$i])
            break
        }
        else
        {
            $PWArray[$i] = 'a'
        }
    }
    return ($PWArray -join '')
}
function Get-Part1 ($inputs)
{
    $Notilo = '[^ilo]'
    $doubleletters =  "(.)\1.*(.)\2"
    $ConsecLetters = Get-ConsecMatcher
    $NoValidPWFound = $true
    $CurrentPassword = $inputs
    While ($novalidpwfound)
    {
        $CurrentPassword = Add-ToPasswordArray -CurrentPassword $CurrentPassword
        if ($CurrentPassword -match $NotIlo)
        {
            if ($CurrentPassword -match $doubleletters)
            {
                if($CurrentPassword -match $ConsecLetters)
                {
                    $NoValidPWFound = $false
                    return $CurrentPassword
                }
            }
        }
    }
}
function Get-Part2 ($inputs)
{
    $Notilo = '[^ilo]'
    $doubleletters =  "(.)\1.*(.)\2"
    $ConsecLetters = Get-ConsecMatcher
    $NoValidPWFound = $true
    $CurrentPassword = 'vzbxxyzz'
    While ($novalidpwfound)
    {
        $CurrentPassword = Add-ToPasswordArray -CurrentPassword $CurrentPassword
        if ($CurrentPassword -match $NotIlo)
        {
            if ($CurrentPassword -match $doubleletters)
            {
                if($CurrentPassword -match $ConsecLetters)
                {
                    $NoValidPWFound = $false
                    return $CurrentPassword
                }
            }
        }
    }
}
Get-Part1 -inputs $inputs
Get-Part2 -inputs $inputs

