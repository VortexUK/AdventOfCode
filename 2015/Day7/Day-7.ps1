$in = Get-Content "C:\Users\Ben\SkyDrive\Documents\PowerShellChallenge\Day-7_input.txt"

$values = @{}

$first = $in | sort | ? {$_ -match "^[0-9]+ ->"}

foreach ($i in $first)
{
    $do = $i -split ' -> '
    $values.($do[1]) = $do[0]
}
$noend = $true
$currentvalues = $values
$remaininginstructions = $in | Where {$_ -notin $first}
while ($noend)
{
    $regexmatcher = $currentvalues.GetEnumerator().Name -join '|'
    $mainmatcher = $values.GetEnumerator().Name -join '|'
    $instructionround = $remaininginstructions | ? {$_ -match "^((([0-9]+|$mainmatcher) (AND|OR|LSHIFT|RSHIFT)) ([0-9]+|$mainmatcher)|NOT ($mainmatcher)|([0-9]+|$mainmatcher)) ->"}
    $previousinstructions = $instructionround
    #$instructionround = $in
    $currentvalues = @{}
    foreach ($instruction in $instructionround)
    {
        $inp,$out = $instruction -split ' -> '
        switch -regex ($inp)
        {
            'AND' {$result = $values.($inp -replace '([a-z]+) AND.*','$1') -band $values.($inp -replace '.*AND ([0-9a-z]+).*','$1')}
            'OR' {$result = $values.($inp -replace '([a-z]+) OR.*','$1') -bor $values.($inp -replace '.*OR ([0-9a-z]+).*','$1')}
            'LSHIFT' {$result = $values.($inp -replace '([a-z]+) LSHIFT.*','$1') -shl ($inp -replace '.*LSHIFT ([0-9]+).*','$1')}
            'RSHIFT' {$result = $values.($inp -replace '([a-z]+) RSHIFT.*','$1') -shr ($inp -replace '.*RSHIFT ([0-9]+).*','$1')}
            'NOT' {$result = 65536 + -bnot $values.($inp -replace 'NOT ([0-9a-z]+).*','$1')} 
            default {$result = $values.($inp -replace '([0-9a-z]+).*','$1')}
        }
        $values.$out = $result
        $currentvalues.$out = $result
        
        if ($out -eq 'a' -and $values.'a' -ne 0) {$noend = $false}
    }
    $remaininginstructions = $remaininginstructions | Where {$_ -notin $previousinstructions}
    if (($remaininginstructions | measure).Count -eq 0)
    {
        $noend = $false
    }
    $previousinstructions
    if (($previousinstructions | measure).Count -eq 0)
    {
        Write-host "Shit" -ForegroundColor Red
    }
    Write-Host "-----"
    #$mainmatcher
}
$values.GetEnumerator() | sort Name | ft -AutoSize