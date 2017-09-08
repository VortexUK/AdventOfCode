$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day19\input.txt"
$molecule = $inputs[-1].Trim()
Function Format-Replacements ($replacements,$part)
{
    $FormattedReplacements = @()
    foreach ($line in $replacements)
    {
        $linesplit = ($line -split '=>').Trim()
        if ($Part -eq 1)
        {
            $FormattedReplacements += New-Object -TypeName PSObject -Property ([ordered]@{
                'Remove' = $linesplit[0]
                'Add' = $linesplit[1]
            })
        }
        else
        {
            $FormattedReplacements += New-Object -TypeName PSObject -Property ([ordered]@{
                'Add' = $linesplit[0]
                'Remove' = $linesplit[1]
            })
        }
    }
    return $FormattedReplacements
}
function Get-Part1 ($replacements)
{
    $PossibleMolecules = New-Object -TypeName System.Collections.ArrayList($null)
    foreach ($Replacement in $replacements)
    {
        $Matches = (Select-String -Pattern $Replacement.Remove -InputObject $molecule -AllMatches -CaseSensitive).Matches
        foreach ($StrMatch in $Matches)
        {
            $null = $PossibleMolecules.Add($molecule.remove($StrMatch.Index,$StrMatch.Length).insert($StrMatch.Index,$Replacement.Add))
        }
    }
    return ($PossibleMolecules | Select -Unique).Count
}
function Get-Part2 ($replacements)
{
    $CurrentMolecule = $molecule
    $Count = 0 
    While ($CurrentMolecule -ne 'e')
    {
        foreach ($Replacement in $replacements)
        {
            $Matches = (Select-String -Pattern $Replacement.Remove -InputObject $CurrentMolecule -AllMatches -CaseSensitive).Matches
            if (($Matches | measure).Count -gt 0)
            {
                $StrMatch = $Matches | Select -first 1
                $CurrentMolecule = ($CurrentMolecule.remove($StrMatch.Index,$StrMatch.Length).insert($StrMatch.Index,$Replacement.Add))
                $count++
            }
        }
    }
    return $Count
}
$replacements1 = Format-Replacements -replacements ($inputs | ? {$_ -match '=>'}) -part 1
Get-Part1 -replacements $replacements1
$replacements2 = Format-Replacements -replacements ($inputs | ? {$_ -match '=>'}) -part 2
Get-Part2 -replacements $replacements2