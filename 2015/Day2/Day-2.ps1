$presents = get-content D:\presents.txt

$total = 0
$totalribbon = 0

foreach ($present in $presents)
{
    [int[]]$presentsplit = $present -split 'x'
    $volume = $presentsplit[0] * $presentsplit[1] * $presentsplit[2]
    $side1 = $presentsplit[0] * $presentsplit[1]
    $side2 = $presentsplit[0] * $presentsplit[2]
    $side3 = $presentsplit[1] * $presentsplit[2]
    $smallestside = $side1
    $smallestperimeter = ($presentsplit[0] * 2) + ($presentsplit[1] * 2)
    if ($smallestside -gt $side2)
    {
        $smallestside = $side2
        $smallestperimeter = ($presentsplit[0] * 2) + ($presentsplit[2] * 2)
    }
    if ($smallestside -gt $side3)
    {
        $smallestside = $side3
        $smallestperimeter = ($presentsplit[1] * 2) + ($presentsplit[2] * 2)
    }
    $total += ($side1 *2) + ($side2 *2) + ($side3 *2) +$smallestside
    $totalribbon += ($smallestperimeter + $volume)
    
}