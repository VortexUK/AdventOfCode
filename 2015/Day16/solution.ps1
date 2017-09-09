$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day16\input.txt"
$MainAuntProps = @{
    'children' = 3
    'cats' = 7
    'samoyeds' = 2
    'pomeranians' = 3
    'akitas' = 0
    'vizslas' = 0
    'goldfish' = 5
    'trees' = 3
    'cars' = 2
    'perfumes' = 1
}
function Format-Inputs ($inputs)
{
    $PossibleAunts = @()
    foreach ($inp in $inputs)
    {
        [int]$AuntID,$PropUnformmated = ($inp -replace '^Sue ([0-9]+): (.*)','$1,$2' -split ',').Trim()
        $PossibleAunt = New-Object -TypeName PSObject -Property ([ordered]@{
            'ID' = $AuntID
            'children' = $null
            'cats' = $null
            'samoyeds' = $null
            'pomeranians' = $null
            'akitas' = $null
            'vizslas' = $null
            'goldfish' = $null
            'trees' = $null
            'cars' = $null
            'perfumes' = $null
        })
        foreach ($prop in $PropUnformmated)
        {
            $propsplit = ($Prop -split ':').Trim()
            $PossibleAunt.($Propsplit[0]) = [int]$Propsplit[1]
        }
        foreach($auntProperty in $MainAuntProps.GetEnumerator().Name)
        {
            if ($possibleaunt.$auntproperty -eq $null)
            {
                $possibleaunt.$auntproperty = 'Unknown'
            }
        }
        $PossibleAunts += $PossibleAunt
    }
    return $PossibleAunts
}
$PossibleAunts = Format-Inputs -inputs $inputs
function Get-Part1 ($PossibleAunts)
{
    $AuntsStillInRunning = $PossibleAunts
    foreach ($property in $MainAuntProps.GetEnumerator().Name)
    {
        $AuntsStillInRunning = $AuntsStillInRunning | Where-Object {$_.$Property -eq $MainAuntProps.$Property -or $_.$property -eq 'Unknown'}
    }
    return $AuntsStillInRunning
}
function Get-Part2 ($PossibleAunts)
{
    $AuntsStillInRunning = $PossibleAunts
    foreach ($property in $MainAuntProps.GetEnumerator().Name)
    {
        switch -regex ($property)
        {
            'cats|trees' {$AuntsStillInRunning = $AuntsStillInRunning | Where-Object {$_.$Property -gt $MainAuntProps.$Property -or $_.$property -eq 'Unknown'}}
            'pomeranians|goldfish' {$AuntsStillInRunning = $AuntsStillInRunning | Where-Object {$_.$Property -lt $MainAuntProps.$Property -or $_.$property -eq 'Unknown'}}
            default {$AuntsStillInRunning = $AuntsStillInRunning | Where-Object {$_.$Property -eq $MainAuntProps.$Property -or $_.$property -eq 'Unknown'}}
        }
    }
    return $AuntsStillInRunning
}
Get-Part1 -PossibleAunts $PossibleAunts
Get-Part2 -PossibleAunts $PossibleAunts