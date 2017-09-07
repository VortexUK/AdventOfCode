$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day6\input.txt"
$regex = '(turn )?(on|off|toggle) ([0-9]{1,3}),([0-9]{1,3}) through ([0-9]{1,3}),([0-9]{1,3})'
function Format-Instruction ($instruction)
{
    $action = $instruction -replace $regex,'$2'
    $xstart = [int]($instruction -replace $regex,'$3')
    $ystart = [int]($instruction -replace $regex,'$4')
    $xend = [int]($instruction -replace $regex,'$5')
    $yend = [int]($instruction -replace $regex,'$6')
    $InstructionObject = New-Object -TypeName PSObject -Property @{
        'Action' = $Action
        'From' =  @{
            'X' = $xstart
            'Y' = $ystart
        }
        'To' =  @{
            'X' = $xend
            'Y' = $yend
        }
    }
    return $InstructionObject
}
function Get-Part1 ($inputs)
{
    $lights = @(0) * 1000
    0..999 | % {$lights[$_] = @(0) *1000}
    $count = 0
    foreach ($inp in $inputs)
    {
        $instruction = Format-Instruction -instruction $Inp
        for ($x = $Instruction.From.X; $x -le $Instruction.To.X;$x++)
        {
            for ($y = $Instruction.From.Y; $y -le $Instruction.To.Y;$y++)
            {
                switch ($instruction.action)
                {
                    "toggle" {if ($lights[$x][$y] -ne 0) {$lights[$x][$y] = 0} else {$lights[$x][$y] = 1}}
                    "off"   {$lights[$x][$y] = 0}
                    "on"  {$lights[$x][$y] =1}
                }
            }
        }
    }
    $NumLights = ($lights[0..1000] | % {$_ | measure -sum | select -ExpandProperty Sum}) | measure -sum | Select -ExpandProperty sum
    return $NumLights
}
function Get-Part2 ($inputs)
{
    $lights = @(0) * 1000
    0..999 | % {$lights[$_] = @(0) *1000}
    $count = 0
    foreach ($inp in $inputs)
    {
        $instruction = Format-Instruction -instruction $Inp
        for ($x = $Instruction.From.X; $x -le $Instruction.To.X;$x++)
        {
            for ($y = $Instruction.From.Y; $y -le $Instruction.To.Y;$y++)
            {
                switch ($instruction.action)
                {
                    "toggle" {$lights[$x][$y] += 2}
                    "off"   {if ($lights[$x][$y] -ne 0) {$lights[$x][$y]--}}
                    "on"  {$lights[$x][$y]++}
                }
            }
        }
    }
    $Luminosity = ($lights[0..1000] | % {$_ | measure -sum | select -ExpandProperty Sum}) | measure -sum | Select -ExpandProperty sum
    #$t = ($lights[0..1000] | % {$_ | measure -sum | select -ExpandProperty Sum}) | measure -sum
    #$t | Select -ExpandProperty Count | measure -sum
    return $Luminosity
}
Get-Part1 -inputs $inputs
Get-Part2 -inputs $inputs