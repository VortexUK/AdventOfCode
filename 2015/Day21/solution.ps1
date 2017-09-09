$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day21\input.txt"
$boss = @{}
foreach ($line in $inputs)
{
    $linesplit = ($line -split ':').Trim() -replace ' '
    $boss.($linesplit[0]) = [int]$linesplit[1]
}
$playerdefault = @{
 'HitPoints' = 100
 'Damage' = 8
 'Armor' = 4
}
$weaponsuf = @(
'Dagger,8,4',
'Shortsword,10,5',
'Warhammer,25,6',
'Longsword,40,7',
'Greataxe,74,8'
)
$weapons = @()
foreach ($weapon in $weaponsuf)
{
    $wsplit = $weapon -split ','
    $weapons += New-Object -TypeName PSObject -Property ([ordered]@{
        'Name' = $wsplit[0]
        'Cost' =[int]$wsplit[1]
        'Damage' =[int]$wsplit[2]
    })
}
$armoruf = @(
'Nothing,0,0,0'
'Leather, 13,0,1'
'Chainmail,31,0,2'
'Splintmail,53,0,3'
'Bandedmail,75,0,4'
'Platemail,102,0,5'
)
$armors = @()
foreach ($armor in $armoruf)
{
    $wsplit = $armor -split ','
    $armors += New-Object -TypeName PSObject -Property ([ordered]@{
        'Name' = $wsplit[0]
        'Cost' =[int]$wsplit[1]
        'Damage' =[int]$wsplit[2]
        'Armor' =[int]$wsplit[3]
    })
}
$ringsuf = @(
'Nothing,0,0,0'
'Damage +1,25,1,0'
'Damage +2,50,2,0'
'Damage +3,100,3,0'
'Defense +1,20,0,1'
'Defense +2,40,0,2'
'Defense +3,80,0,3'
)
$rings = @()
foreach ($ring in $ringsuf)
{
    $wsplit = $ring -split ','
    $rings += New-Object -TypeName PSObject -Property ([ordered]@{
        'Name' = $wsplit[0]
        'Cost' =[int]$wsplit[1]
        'Damage' =[int]$wsplit[2]
        'Armor' =[int]$wsplit[3]
    })
}
function Get-Part1
{
    $bestcost = 1000
    foreach ($weapon in $weapons)
    {
        foreach ($armor in $armors)
        {
            foreach ($ring in $rings)
            {
                foreach ($ring2 in ($rings | ? {$_.Name -ne $Ring.Name -or $_.Name -eq 'Nothing'}))
                {
                    $playerdmggiven = ($weapon.damage + $ring.damage + $ring2.damage)- $boss.Armor
                    if ($playerdmggiven -le 0) {$playerdmggiven = 1}
                    $playerdmgtaken = $boss.Damage - ($armor.armor + $ring.armor + $ring2.armor)
                    if ($playerdmgtaken -le 0) {$playerdmgtaken = 1}
                    $playerroundsrequired = [math]::Ceiling(($boss.HitPoints/$playerdmggiven))
                    $bossroundsrequired = [math]::Ceiling((100/$playerdmgtaken))
                    if ($playerroundsrequired -le $bossroundsrequired)
                    {
                        $winningcost = $weapon.cost + $armor.cost + $ring.cost + $ring2.cost
                        if ($winningcost -lt $bestcost)
                        {
                            $bestcost = $winningcost
                        }
                    }
                }
            }
        }
    }
    return $bestcost
}
function Get-Part2
{
    $bestcost = 0
    foreach ($weapon in $weapons)
    {
        foreach ($armor in $armors)
        {
            foreach ($ring in $rings)
            {
                foreach ($ring2 in ($rings | ? {$_.Name -ne $Ring.Name -or $_.Name -eq 'Nothing'}))
                {
                    $playerdmggiven = ($weapon.damage + $ring.damage + $ring2.damage)- $boss.Armor
                    if ($playerdmggiven -le 0) {$playerdmggiven = 1}
                    $playerdmgtaken = $boss.Damage - ($armor.armor + $ring.armor + $ring2.armor)
                    if ($playerdmgtaken -le 0) {$playerdmgtaken = 1}
                    $playerroundsrequired = [math]::Ceiling(($boss.HitPoints/$playerdmggiven))
                    $bossroundsrequired = [math]::Ceiling((100/$playerdmgtaken))
                    if ($playerroundsrequired -gt $bossroundsrequired)
                    {
                        $winningcost = $weapon.cost + $armor.cost + $ring.cost + $ring2.cost
                        if ($winningcost -gt $bestcost)
                        {
                            $bestcost = $winningcost
                        }
                    }
                }
            }
        }
    }
    return $bestcost
}
Get-Part1
Get-Part2