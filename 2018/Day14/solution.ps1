[system.int32]$inp =846601
$RecipeCount = 10
$state2 = @{
    Recipes = '37'
    Elf1Pos = 0
    Elf2Pos = 1
}
function get-newrecipes ($statetochange)
{
    ($statetochange.Recipes[$statetochange.Elf1Pos] + $statetochange.Recipes[$statetochange.Elf2Pos]) -split '(?<=.)(?=.)' | ForEach-Object -Process {$null = $statetochange.Recipes.Add([int]$_)}
    $statetochange.Elf1Pos = ($statetochange.Elf1Pos + $statetochange.Recipes[($statetochange.Elf1Pos)] +1) %  $statetochange.Recipes.Count
    $statetochange.Elf2Pos = ($statetochange.Elf2Pos + $statetochange.Recipes[($statetochange.Elf2Pos)] +1) % $statetochange.Recipes.Count
    return $statetochange
}

$recipenotfound = $true
$indexCount = 0
$matcher = [regex]::New($inp)
while ($recipenotfound)
{
    $indexcount++
    $state = get-newrecipes -statetochange $state
    if (($state.Recipes.Count - $RecipeCount -gt $inp ))
    {
        $RecipeNumber = $state.Recipes[($inp)..($inp+9)]
    }
    if ($indexcount % 10000 -eq 0)
    {
        $indexCount
         $result = $matcher.matches(($state.Recipes[($state.Recipes.Count-20000)..($state.Recipes.Count-1)] -join ''))
        if ($null -eq $Result)
        {
            $recipenotfound = $false
        }
    }
}
$RecipeNumber -join ''
