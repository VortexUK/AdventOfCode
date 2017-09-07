$inputs = get-content -Path "D:\git\AdventOfCode\2015\Day9\input.txt"
function Remove ($element, $list)
{
    $newList = @()
    $list | % { if ($_ -ne $element) { $newList += $_} }

    return $newList
}
function Append ($head, $tail)
{
    if ($tail.Count -eq 0)
        { return ,$head }

    $result =  @()

    $tail | %{
        $newList = ,$head
        $_ | %{ $newList += $_ }
        $result += ,$newList
    }

    return $result
}
function Permute ($list)
{
    if ($list.Count -eq 0)
        { return @() }

    $list | %{
        $permutations = Permute (Remove $_ $list)
        return Append $_ $permutations
    }
}
function Format-Inputs ($inputs)
{
    $TravelMap = New-Object -TypeName PSOBject -Property @{
        'Locations' = @()
        'Map' = @{}
    }
    foreach ($inp in $inputs)
    {
        $Source,$null,$Destination,$null,$Distance = $inp -split '\s'
        if ($TravelMap.Locations -notcontains $Source)
        {
            $TravelMap.Locations += $Source
        }
        if ($TravelMap.Locations -notcontains $Destination)
        {
            $TravelMap.Locations += $Destination
        }
        if ($TravelMap.Map.$Source -eq $null)
        {
            $TravelMap.Map.$Source = @{}
            $TravelMap.Map.$Source.$Destination = $Distance
        }
        else
        {
            $TravelMap.Map.$Source.$Destination = $Distance
        }
        if ($TravelMap.Map.$Destination -eq $null)
        {
            $TravelMap.Map.$Destination = @{}
            $TravelMap.Map.$Destination.$Source = $Distance
        }
        else
        {
            $TravelMap.Map.$Destination.$Source = $Distance
        }
    }
    return $TravelMap
}
$TravelMap = Format-Inputs -inputs $inputs
$PossibleRoutes = Permute -list $TravelMap.Locations
function Get-Part1 ($TravelMap)
{
    $ShortestLength = 99999
    foreach ($Route in $PossibleRoutes)
    {
        $RouteLength = 0
        for ($i = 0; $i -lt ($Route.Length); $i++)
        {
            $RouteLength += $TravelMap.Map.($Route[$i]).($Route[$i+1])
        }
        if ($RouteLength -lt $ShortestLength)
        {
            $ShortestLength = $RouteLength
        }
    }
    return $ShortestLength
}
function Get-Part2 ($inputs)
{
    $longestlength = 0
    foreach ($Route in $PossibleRoutes)
    {
        $RouteLength = 0
        for ($i = 0; $i -lt ($Route.Length); $i++)
        {
            $RouteLength += $TravelMap.Map.($Route[$i]).($Route[$i+1])
        }
        if ($RouteLength -gt $longestlength)
        {
            $longestlength = $RouteLength
        }
    }
    return $longestlength
}
Get-Part1 -TravelMap $TravelMap
Get-Part2 -inputs $inputs