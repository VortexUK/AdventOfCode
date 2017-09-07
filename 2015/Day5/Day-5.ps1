$strings = get-content D:\presents.txt

$rule1 = "[aeiou].*[aeiou].*[aeiou]"
$rule2 = "([a-z])\1"
$rule3 = "ab|cd|pq|xy" 
$rule4 = "(..).*\1"
$rule5 = "(.).\1"


$firstpart = ($strings | ? {$_ -notmatch $rule3 -and $_ -match $rule1 -and $_ -match $rule2} | Measure).Count
$secondpart = ($strings | ? {$_ -match $rule4 -and $_ -match $rule5} | Measure).Count
$firstpart
$secondpart