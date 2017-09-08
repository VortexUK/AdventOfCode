$inp = gc "C:\Users\bmcel\OneDrive\Documents\PowerShellChallenge\Day-17_input.txt"
$count = 1
$goodcombos = @()
function Test-Value ($start, $inputs)
{
    $count = 0
    $index = 0
    foreach ($value in $inputs)
    {
        $testvalue = $start + $Value
        if ($testvalue -eq 150)
        {
            $combo = (((compare-object $inp $inputs).InputObject) + $value | sort ) -join ','
            if ($script:goodcombos -notcontains $combo)
            {
                $count++
                $script:goodcombos += $combo
                Write-Host "Found one!"
                
            }
            return $count
        }
        if ($testvalue -gt 150)
        {
            return $count
        }
        $inputlength = ($inputs | Measure-Object).Count 
        if ($inputlength -gt 1)
        {
            $newinputs = New-Object System.Collections.ArrayList($null)
            for ($i=0; $i -lt $inputlength; $i++)
            {
                if($i -ne $index)
                {
                    $null = $newinputs.add($inputs[$i])
                }
            }
            $count += (Test-Value -start $testvalue -inputs $newinputs)
        }
        $index++
    }
    return $count
}



$currentcount = ($goodcombos | ? {$_ -notmatch "40|18"} | measure).Count
$currentcount +=  ($goodcombos | ? {$_ -match "18.*18" -and $_ -notmatch "40"} | measure).Count # only both 18s
$currentcount +=  ($goodcombos | ? {$_ -match "18" -and $_ -notmatch "18.*18" -and $_ -notmatch "40"} | measure).Count * 2# 1 18 no 40s
$currentcount +=  ($goodcombos | ? {$_ -match "18" -and $_ -notmatch "18.*18" -and $_ -match "40"} | measure).Count * 4# 1 18 1 40
$currentcount +=  ($goodcombos | ? {$_ -match "18.*18" -and $_ -match "40"} | measure).Count *2 # 2 18 1 40
$currentcount +=  ($goodcombos | ? {$_ -notmatch "18" -and $_ -match "40"} | measure).Count *2 # no 18 1 40



$currentcount +=  ($goodcombos | ? {$_ -match "40.*40" -and $_ -notmatch "18"} | measure).Count # only both 40s
$currentcount +=  ($goodcombos | ? {$_ -match "40.*40" -and $_ -match "18(?!.*18)"} | measure).Count # #40s + 1 18