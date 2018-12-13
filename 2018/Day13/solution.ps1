[System.String[]]$inp = Get-Content -Path \\czxbenm1\d$\day13.txt
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
    hidden [System.Collections.Hashtable]$CornerChange = @{
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
    hidden [System.Collections.Hashtable]$CrossingChange = @{
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

    [System.String] Move ($Instruction)
    {
        switch -regex ($Instruction)
        {
            '\\|\/' 
            {
                $NewDirection = $this.CornerChange["$Instruction"]["$($this.Direction)"]
                $this.ChangeDirection($NewDirection , $false)
            }
            '\+' 
            {
                $NewDirection = $this.CrossingChange["$($this.Direction)"]["$($this.NextTurn)"]
                $this.ChangeDirection($NewDirection, $true)
            }

        }
        $this.X += $this.MoveX
        $this.Y += $this.MoveY
        Return "$($this.Y)-$($this.X)"
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

$NoCrash = $true
while($NoCrash)
{
    $CartLocations = @{}
    foreach ($Cart in $Minecarts)
    {
        $Instruction = $MineMap[$Cart.Y][$Cart.X]
        $NewLocation = $Cart.Move($Instruction)
        if ($NewLocation -in $CartLocations.Values)
        {
            $NoCrash = $false
            $Part1 = $NewLocation
        }
        else
        {
            $CartLocations["$($Cart.Index)"] = $NewLocation
        }

    }
}
