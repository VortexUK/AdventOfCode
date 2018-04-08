$InputPath = "$((Get-Location).Path)\input.txt"
$InputContent = Get-Content -Path $InputPath
$Integers = $InputContent -split '(?<=.)(?=.)'
function Get-Part1 ($Integers)
{
    $InputCount = $Integers.Count
    $Sum = 0
    for($i = 0; $i -lt $InputCount; $i++)
    {
        if ($Integers[$i-1] -eq $Integers[$i])
        {
            $Sum += $Integers[$i]
        }
    }
    Write-Output "The Answer to part 1 is: $Sum"
}
function Get-Part2 ($Integers)
{
    $InputCount = $Integers.Count
    $Sum = 0
    for($i = 0; $i -lt $InputCount; $i++)
    {
        if ($Integers[$i] -eq $Integers[(($i+($inputCount/2)) % $inputcount)])
        {
            $Sum += $Integers[$i]
        }
    }
    Write-Output "The Answer to part 2 is: $Sum"
}
Get-Part1($Integers)
Get-Part2($Integers)