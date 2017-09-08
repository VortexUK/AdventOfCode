$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day15\input.txt"

function Format-Inputs ($inputs)
{
    $Ingredients =@()
    foreach ($inp in $inputs)
    {
        $name,$props = $inp -replace '([a-z]+): ([a-z]+) ([-0-9]+), ([a-z]+) ([-0-9]+), ([a-z]+) ([-0-9]+), ([a-z]+) ([-0-9]+), ([a-z]+) ([-0-9]+)','$1,$2>$3 $4>$5 $6>$7 $8>$9 $10>$11' -split ','
        $Ingredient = New-Object -TypeName PSObject -Property @{
            'Name' = $name
            'Properties' = @{}
        }
        $properties = $props -split ' '
        foreach ($property in $properties)
        {
            $propsplit = $property -split '>'
            $Ingredient.Properties.($propsplit[0]) = [int]$propsplit[1]
        }
        $Ingredients += $Ingredient
    }
    return $Ingredients
}
function Get-Product ($a) {
    if ($a.Length -eq 0) {
        return 0
    }
    $s = $a -join '*'
    return (Invoke-Expression $s)
}
$Ingredients = Format-Inputs -inputs $inputs
function Get-Part1 ($Ingredients)
{
    $bestcombo = 0
    for ($i = 0;$i -lt 100;$i--)
    {
        for($j = 0; $j -lt (100-$i);$j++)
        {
            for($k =0;$k -lt (100-($i +$j));$k++)
            {
                $badcombo = $false
                $l = 100-$i-$j-$k
                $propertyvalues = @()
                foreach ($property in $Ingredients[0].Properties.GetEnumerator().name)
                {
                    if(!$badcombo)
                    {
                        $PropertyValue = ($Ingredients[0].Properties.$property * $i) + ($Ingredients[1].Properties.$property * $j) + ($Ingredients[2].Properties.$property * $k) + ($Ingredients[3].Properties.$property * $l)
                        if ($PropertyValue -le 0)
                        {
                            $Badcombo = $true
                        }
                        $propertyvalues += $PropertyValue
                    }
                }
                if (!$badcombo)
                {
                    $Result = Get-Product -Values $propertyvalues
                    if ($bestcombo -lt $result)
                    {
                        $bestcombo = $result
                        $result
                    }
                }
            }
        }
    }
    return $bestcombo
}
function Get-Part2 ($inputs)
{
}
Get-Part1 -Ingredients $Ingredients
Get-Part2 -inputs $inputs