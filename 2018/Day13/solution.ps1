[System.String[]]$inp = Get-Content -Path D:\git\AdventOfCode\2018\day13\input.txt
[System.Collections.ArrayList]$MineCarts = @()
$MineCartMatcher = [Regex]::New('\<|\>|\^|v')
$lineindex = 0
$MineCartCount = 0

class MineCart
{
    [System.Int32]$Index
    [System.String]$Location =""
    [System.Int32]$Y = 0
    [System.Int32]$X = 0
    [System.Int32]$MoveX = 0
    [System.Int32]$MoveY = 0
    [System.String]$Direction = ''
    [System.String]$NextTurn = 'Left'
    [System.Boolean]$Crashed = $false
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
        $this.SetLocation($X, $Y)
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
    [void] SetLocation($X, $Y)
    {
        $this.X = $X
        $this.Y = $Y
        $this.Location = $X,$Y -join ','
    }
    [void] Move ($Instruction)
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
        $this.SetLocation(($this.X+$this.MoveX),($this.Y+$this.MoveY))
    }
}

foreach ($line in $inp)
{
    $Matches = $MineCartMatcher.Matches($line)
    foreach ($Match in $Matches)
    {
        $Minecartcount++
        $MineCart = [MineCart]::New($Minecartcount,$lineindex,$Match.Index,$Match.Value)
        $null = $MineCarts.Add($Minecart)
    }
    $lineindex++
}
$MineMap = $inp -replace '\<|\>','-' -replace '\^|v','|'
$Part1Start = Get-Date
$Part2Start = Get-Date
$NoCrash = $true
$iterations = 0
$Firstcrash = $true
while($NoCrash)
{
    $iterations++
    :cartloop foreach ($Cart in $MineCarts)
    {
        if ($Cart.Crashed -eq $false)
        {
            $Instruction = $MineMap[$Cart.Y][$Cart.X]
            $Cart.Move($Instruction)
            $MineCartCrash = $MineCarts | Where-Object {$_.Location -EQ $Cart.Location -and $_.Crashed -eq $false}
            if (($MineCartCrash | Measure-Object).Count -ge 2 )
            {
                if ($Firstcrash -eq $true)
                {
                    $Part1 = $Cart.Location
                    $Firstcrash = $false
                    $Part1End = Get-Date
                }
                #$CartsToRemove = $MineCarts | Where-Object -Property Location -eq $MineCarts[$CartIndex].Location
                foreach ($CrashedCart in $MineCartCrash)
                {
                    $CrashedCart.Crashed = $true
                }
            }
            if(($MineCarts | Measure-Object).Count -eq 1)
            {
                $NoCrash = $false
                $Part2 = $Cart.Location
                break cartloop
            }
        }
    }
    $MineCarts = @($MineCarts | Where {$_.Crashed -eq $false} | Sort-Object -Property Y,X)
}
$Part2End = Get-Date
Write-Host -Object "Answer to Part 1: $Part1 (Took $((New-TimeSpan -Start $part1start -End $Part1End).TotalMilliseconds) Milliseconds)" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2 (Took $((New-TimeSpan -Start $Part2Start -End $part2end).TotalSeconds) Seconds)" -ForegroundColor Yellow