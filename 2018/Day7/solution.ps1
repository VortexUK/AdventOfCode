[System.String[]]$inp = Get-Content -Path D:\git\AdventOfCode\2018\Day7\input.txt
[System.Collections.ArrayList]$formattedinput = $inp | Select-Object -Property @{ N = "Required"; E = { ($_ -split ' ')[1].Trim() } }, @{ N = "Step"; E = { ($_ -split ' ')[7].Trim() } }
function Get-ProcessMap ($formattedinput)
{
	$Map = @{ }
	foreach ($Letter in (65 .. 90 | foreach-object{ [System.String][System.Char]$_ }))
	{
		$Map[$Letter] = @()
	}
	foreach ($rule in $formattedinput)
	{
		$Map[$rule.Step] += @($rule.Required)
	}
	return $Map
}
#region Part 1
[System.DateTime]$part1start = Get-date
[System.Collections.HashTable]$Map = Get-ProcessMap -formattedinput $formattedinput
[System.Collections.ArrayList]$LetterOrder = @()
[System.Boolean]$moreletters = $true
while ($moreletters)
{
	$moreletters = $false
	:letterloop foreach ($Letter in (65 .. 90 | foreach-object{ [string][char]$_ }))
	{
		if ((($Map[$Letter] | measure-object).Count -eq 0) -and $Letter -notin $LetterOrder)
		{
			$moreletters = $true
			$null = $LetterOrder.Add($Letter)
			foreach ($RemoveLetter in (65 .. 90 | foreach-object{ [string][char]$_ }))
			{
				try
                {
                $Map.$RemoveLetter = @($Map[$RemoveLetter] | Where-Object -FilterScript { $_ -ne $Letter })
                }
                catch
                {
                    write-host "hat"
                }
			}
			break letterloop # Restart from A or you aren't following the rules :P
		}
	}
}
[System.String]$Part1 = $LetterOrder -join ''
[System.DateTime]$Part1End = Get-Date
#endregion
#region Part 2
[System.DateTime]$Part2Start = Get-date
[System.Collections.HashTable]$Map = Get-ProcessMap -formattedinput $formattedinput
function Get-TimeTaken ($Letter)
{
	return [System.Int32][System.Char]$Letter - 4
}
$Workers = @()
foreach ($Worker in 0 .. 4)
{
	$Workers += New-Object -TypeName PSObject -Property ([ordered]@{
			ID	    = $Worker
			Time    = 0
			Letter  = ''
		})
}
[System.Boolean]$MoreLetters = $true
[System.Collections.ArrayList]$LetterOrder = @()
[System.Int32]$TimeTaken = 0
[System.Collections.ArrayList]$LetterSet = (65 .. 90 | foreach-object{ [string][char]$_ })
while ($MoreLetters)
{
	if (($Workers | Where-Object -Property Time -eq 0 | Measure-Object).count -gt 0)
	{
		foreach ($Worker in 0 .. 4)
		{
			if ($Workers[$Worker].Time -eq 0 -and $Workers[$Worker].Letter -ne '')
			{
				$null = $LetterOrder.Add($Workers[$Worker].Letter)
				foreach ($RemoveLetter in (65 .. 90 | foreach-object{ [string][char]$_ }))
				{
					$Map.$RemoveLetter = @($Map.$RemoveLetter | Where-Object -FilterScript { $_ -ne $Workers[$Worker].Letter })
				}
				$Workers[$Worker].Letter = ''
			}
		}
		[System.Boolean]$MoreWork = $true
		while ($MoreWork)
		{
			[System.Collections.ArrayList]$FreeWorkers = @(($Workers | Where-Object -Property Time -eq 0))
			$WorkDone = $false
			:letterloop foreach ($Letter in $LetterSet | Where-Object { $_ -notin $LetterOrder -and $_ -notin $Workers.Letter })
			{
				if (($FreeWorkers | Measure-Object).Count -gt 0)
				{
					if ((($Map[$Letter] | measure-object).Count -eq 0) -and $Letter -notin $LetterOrder -and $Letter -notin $Workers.Letter -and $WorkDone -eq $false)
					{
						$Workers[($FreeWorkers[0].ID)].Letter = $Letter
						$Workers[($FreeWorkers[0].ID)].Time = Get-TimeTaken -letter $Letter
						$null = $Freeworkers.RemoveAt(0)
						$WorkDone = $true
						break letterloop
					}
				}
				else
				{
					break letterloop
				}
			}
			if ($WorkDone -eq $false)
			{
				$MoreWork = $false
			}
		}
		$LetterSet = @(($LetterSet | Where-OBject { $_ -notin $LetterOrder }))
		if (($Workers | Where-Object -Property Time -ne 0 | Measure-Object).Count -gt 0)
		{
			$Timetaken += 1
			foreach ($Worker in ($Workers | Where-Object -Property Time -ne 0))
			{
				$Worker.Time -= 1
			}
		}
	}
	else
	{
		$inactivetime = $Workers.Time | Sort-Object | Select-Object -first 1
		foreach ($Worker in 0 .. 4)
		{
			$Workers[$Worker].Time -= $inactivetime
		}
		$Timetaken += $inactivetime
	}
	if (($LetterOrder | Measure-Object).Count -eq 26)
	{
		$moreletters = $false
	}
}
$Part2 = $TimeTaken
$part2end = Get-Date
#endregion
Write-Host -Object "Answer to Part 1: $Part1 (Took $((New-TimeSpan -Start $part1start -End $Part1End).Milliseconds) Milliseconds)" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2 (Took $((New-TimeSpan -Start $Part2Start -End $part2end).Milliseconds) Milliseconds)" -ForegroundColor Yellow
