$in = Get-Content "C:\Users\Ben\SkyDrive\Documents\PowerShellChallenge\Day-6_input.txt"

$lights = @(0) * 1000
0..999 | % {$lights[$_] = @(0) *1000}
$count = 0
foreach ($instruction in $in)
{
    $count
    $count++
    $xstart = [int]($instruction -replace '(turn (on|off)|toggle) ([0-9]{1,3}),([0-9]{1,3}) through ([0-9]{1,3}),([0-9]{1,3})','$3')
    $xend = [int]($instruction -replace '(turn (on|off)|toggle) ([0-9]{1,3}),([0-9]{1,3}) through ([0-9]{1,3}),([0-9]{1,3})','$5')
    $ystart = [int]($instruction -replace '(turn (on|off)|toggle) ([0-9]{1,3}),([0-9]{1,3}) through ([0-9]{1,3}),([0-9]{1,3})','$4')
    $yend = [int]($instruction -replace '(turn (on|off)|toggle) ([0-9]{1,3}),([0-9]{1,3}) through ([0-9]{1,3}),([0-9]{1,3})','$6')
    for ($x = $xstart; $x -le $xend;$x++)
    {
        for ($y = $ystart; $y -le $yend;$y++)
        {
            switch -Regex ($instruction)
            {
                "toggle" {$lights[$x][$y] += 2}
                "turn off"   {if ($lights[$x][$y] -ne 0) {$lights[$x][$y]--}}
                "turn on"  {$lights[$x][$y]++}
            }
        }
    }
}

$t = ($lights[0..1000] | % {$_ | measure -sum | select -ExpandProperty Sum}) | measure -sum
$t | Select -ExpandProperty Count | measure -sum