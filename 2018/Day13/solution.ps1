[System.String[]]$inp = Get-Content -Path D:\git\AdventOfCode\2018\Day13\input.txt
$MineCarts = @()
$MineCartMatcher = [Regex]::New('\<|\>|\^|v')
$lineindex = 0
$MineCartCount = 0

class MineCart
{
    [System.Int32]$Index
    [System.Int32]$Y = 0
    [System.Int32]$MoveX = 0
    [System.Int32]$X = 0
    [System.Int32]$MoveY = 0
    [System.String]$Direction = ''
    [System.String]$NextTurn = 'Left'

    MineCart([System.Int32]$Index,[System.Int32]$Y,[System.Int32]$X,[System.String]$Arrow)
    {
        $this.Index = $Index
        $this.Y = $Y
        $this.X = $X
        switch ($Arrow)
        {
            'V' {
                $this.Direction = 'South'
                $this.MoveY = 1
            }
            '^' {
                $this.Direction = 'North'
                $this.MoveY = -1
            }
            '<' {
                $this.Direction = 'West'
                $this.MoveX = -1
            }
            '>' {
                $this.Direction = 'East'
                $this.MoveX = 1
            }
        }
    }

    [void] ResetMovement ()
    {
        $this.MoveX = 0
        $this.MoveY = 0
    }
    [void] JunctionChange ()
    {
        $this.NextTurn = switch ($this.NextTurn)
        {
            'Left' {'Straight'}
            'Straight' {'Right'}
            'Right' {'Left'}
        }
    }
    [void] ChangeDirection ($NewDirection, $AtCrossing)
    {
        $this.Direction = $NewDirection
        $this.ResetMovement()
        switch ($NewDirection)
        {
            'North' { $this.MoveY = -1}
            'South' { $this.MoveY = 1 }
            'East' { $this.MoveX = 1}
            'West' { $this.MoveX = -1}
        }
        if ($AtCrossing)
        {
            $this.JunctionChange()
        }
    }
}

foreach ($line in $inp)
{
    $Matches = $MineCartMatcher.Matches($line)
    foreach ($Match in $Matches)
    {
        $Minecartcount++
        $MineCart = [MineCart]::New($Minecartcount,$lineindex,$Match.Index,$Match.Value)
        $MineCarts += $Minecart
    }
    $lineindex++
}
$MineMap = $inp -replace '\<|\>','-' -replace '\^|v','|'
$CornerChange = @{
    '\' = @{
        'South' = 'East'
        'North' = 'West'
        'East' = 'South'
        'West' = 'North'
    }
    '/' =  @{
        'South' = 'West'
        'North' = 'East'
        'East' = 'North'
        'West' = 'South'
    }
}
$CrossingChange = @{
    'North' = @{
        'Left' = 'West'
        'Straight' = 'North'
        'Right' = 'East'
    }
    'South' = @{
        'Left' = 'East'
        'Straight' = 'South'
        'Right' = 'West'
    }
    'East' = @{
        'Left' = 'North'
        'Straight' = 'East'
        'Right' = 'South'
    }
    'West' = @{
        'Left' = 'South'
        'Straight' = 'West'
        'Right' = 'North'
    }
}
function Move-MineCart($Cart,$MineMap)
{
    $currentlocation = $MineMap[$Cart.Y][$Cart.X]

    switch -regex ($currentlocation)
    {
        '\\|\/' 
        {
            $NewDirection = $CornerChange["$currentlocation"]["$($cart.Direction)"]
            $Cart.ChangeDirection($NewDirection , $false)
        }
        '\+' 
        {
            $NewDirection = $CrossingChange["$($cart.Direction)"]["$($Cart.NextTurn)"]
            $Cart.ChangeDirection($NewDirection, $true)
        }

    }
    $Cart.X += $Cart.MoveX
    $Cart.Y += $Cart.MoveY
    return $cart
}
