$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day7\input.txt"
function Get-FormattedInputs ($inputs)
{
    $formattedinputs = New-Object -TypeName System.Collections.ArrayList($null)
    foreach ($inp in $inputs)
    {
        $left,$right = ($inp -split ' -> ').Trim()
        $Instruction = New-Object -TypeName PSObject -Property @{
                    'InputA' = ''
                    'InputB' = ''
                    'Output' = $right
                    'Operation' = ''
                }
        switch -regex ($left)
        {
            '^[0-9]+$'
            {
                $Instruction.InputA = $left
                $Instruction.Operation += 'START'
            }
            'AND|OR|[LR]SHIFT' 
            {
                $inputs = ($left -split ' ' | Where {$_ -notmatch 'AND|OR|[LR]SHIFT'}).Trim()
                $Instruction.InputA = $inputs[0]
                $Instruction.InputB = $inputs[1]
                $Instruction.Operation += ($left -replace '.*(AND|OR|[LR]Shift).*','$1').Trim()
            }
            'NOT' 
            {
                $Instruction.InputA = ($left -replace '.*NOT ').Trim()
                $Instruction.Operation += 'NOT'
            }
            default
            {
                $Instruction.InputA = $left
                $Instruction.Operation += 'ASSIGN'
            }
        }
        $null = $formattedinputs.Add($Instruction)
    }
    return $formattedinputs
}
Function Initialise-Circuit ($StartingInputs)
{
    $CircuitValues = @{}
    foreach ($AssignValue in $StartingInputs)
    {
        $CircuitValues.($AssignValue.Output) = $AssignValue.InputA
    }
    return $CircuitValues
}
function Get-Part1
{
    [System.Collections.ArrayList]$formattedinputs = Get-FormattedInputs -inputs $inputs
    $StartingInputs = $formattedinputs | Where {$_.Operation -eq "START"}
    $CircuitValues = Initialise-Circuit -StartingInputs $StartingInputs
    $StartingInputs | Foreach  {$formattedinputs.Remove($_)}
    $noend = $true
    while ($noend)
    {
        $mainmatcher = "^([0-9]+|$($CircuitValues.Keys -join '|'))$"
        $instructionround = $formattedinputs | Where {($_.InputA -match $mainmatcher -and $_.InputB -eq '') -or ($_.InputA -match $mainmatcher -and $_.InputB -match $mainmatcher)}
        foreach ($instruction in $instructionround)
        {
            if ($instruction.InputA -match '[a-z]+')
            {
                $InputA = $CircuitValues.($instruction.InputA)
            }
            else
            {
                $InputA = $instruction.InputA
            }
            if ($instruction.InputB -match '[a-z]+')
            {
                $InputB = $CircuitValues.($instruction.InputB)
            }
            else
            {
                $InputB = $instruction.InputB
            }
            $Output = $instruction.Output
            switch ($instruction.Operation)
            {
                'AND' {$result = $InputA -band $InputB}
                'OR' {$result = $InputA -bor $InputB}
                'LSHIFT' {$result = $InputA -shl $InputB}
                'RSHIFT' {$result = $InputA -shr $InputB}
                'NOT' {$result = 65536 + -bnot $InputA}
                'ASSIGN' {$result = $InputA}
            }
            $CircuitValues.$Output = $result
            if ($out -eq 'a' -and $CircuitValues.'a' -ne 0) {$noend = $false}
            $formattedinputs.Remove($instruction)
        }
        if (($formattedinputs | measure).Count -eq 0)
        {
            $noend = $false
        }
        if (($instructionround | measure).Count -eq 0)
        {
            Write-host "Shit" -ForegroundColor Red
        }
    }
    #$CircuitValues.GetEnumerator() | sort Name
    return $CircuitValues.A
}
function Get-Part2 ($inputs)
{
    [System.Collections.ArrayList]$formattedinputs = Get-FormattedInputs -inputs $inputs
    $StartingInputs = $formattedinputs | Where {$_.Operation -eq "START"}
    $CircuitValues = Initialise-Circuit -StartingInputs $StartingInputs
    # CHANGE B to be the output from part 1:
    $CircuitValues.B = 956
    $StartingInputs | Foreach  {$formattedinputs.Remove($_)}
    $noend = $true
    while ($noend)
    {
        $mainmatcher = "^([0-9]+|$($CircuitValues.Keys -join '|'))$"
        $instructionround = $formattedinputs | Where {($_.InputA -match $mainmatcher -and $_.InputB -eq '') -or ($_.InputA -match $mainmatcher -and $_.InputB -match $mainmatcher)}
        foreach ($instruction in $instructionround)
        {
            if ($instruction.InputA -match '[a-z]+')
            {
                $InputA = $CircuitValues.($instruction.InputA)
            }
            else
            {
                $InputA = $instruction.InputA
            }
            if ($instruction.InputB -match '[a-z]+')
            {
                $InputB = $CircuitValues.($instruction.InputB)
            }
            else
            {
                $InputB = $instruction.InputB
            }
            $Output = $instruction.Output
            switch ($instruction.Operation)
            {
                'AND' {$result = $InputA -band $InputB}
                'OR' {$result = $InputA -bor $InputB}
                'LSHIFT' {$result = $InputA -shl $InputB}
                'RSHIFT' {$result = $InputA -shr $InputB}
                'NOT' {$result = 65536 + -bnot $InputA}
                'ASSIGN' {$result = $InputA}
            }
            $CircuitValues.$Output = $result
            if ($out -eq 'a' -and $CircuitValues.'a' -ne 0) {$noend = $false}
            $formattedinputs.Remove($instruction)
        }
        if (($formattedinputs | measure).Count -eq 0)
        {
            $noend = $false
        }
        if (($instructionround | measure).Count -eq 0)
        {
            Write-host "Shit" -ForegroundColor Red
        }
    }
    #$CircuitValues.GetEnumerator() | sort Name
    return $CircuitValues.A
}
Get-Part1 -inputs $inputs
Get-Part2 -inputs $inputs