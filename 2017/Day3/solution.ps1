$InputPath = "$PSScriptRoot\input.txt"
$InputContent = Get-Content -Path $InputPath

class spiral
{
    $PrevNegY = 0
    $PosX = 1
    $PosXDiag = 0
    $PosY = 1
    $PosYDiag = 0
    $NegX = 1
    $NegXDiag = 0
    $NegY = 1
    $NegYDiag = 0
    $currentring = 0
    $currentadd = 1
    spiral ()
    {
    }

    [void] nextposition ()
    {
        $this.PosX = $this.PosX + $this.currentadd
        $this.currentadd += 2
        $this.PosY = $this.PosY + $this.currentadd
        $this.currentadd += 2
        $this.NegX = $this.NegX + $this.currentadd
        $this.currentadd += 2
        $this.PrevNegY = $this.NegY
        $this.NegY = $this.NegY + $this.currentadd
        $this.currentadd += 2
        $this.currentring += 1
    }

    [bool] testposition([int]$number)
    {
        if ($number -le $this.NegY)
        {
            return $true
        }
        else
        {
            return $false
        }
    }
    [int] getdistance($number)
    {
        if ($number -le $this.NegX)
        {
            if ($Number -le $this.PosY)
            {
                if ($Number -le $this.PosX)
                {
                    # Number is in that annoying quadrant... time for some fun
                    # Between PrevNegY and PosX
                    if (($this.PosX - $Number) -ge ($Number - $this.PrevNegY))
                    {
                        # Closer to the prevnegy, which is part of the previous ring
                        $Distance = ($this.currentring -1) + ($Number - $this.PrevNegY)
                    }
                    else
                    {
                        $Distance = $this.currentring + ($this.PosX - $Number)
                    }
                }
                else
                {
                    # Num between PosY and PosX
                    if (($this.PosY - $Number) -ge ($Number - $this.PosX))
                    {
                        $Distance = $this.currentring + ($Number - $this.PosX)
                    }
                    else
                    {
                        $Distance = $this.currentring + ($this.PosY - $Number)
                    }
                }
            }
            else
            {
                # Num between NegX and PosY
                if (($this.NegX - $Number) -ge ($Number - $this.PosY))
                {
                    $Distance = $this.currentring + ($Number - $this.PosY)
                }
                else
                {
                    $Distance = $this.currentring + ($this.NegX - $Number)
                }

            }
        }
        else
        {
            # Num between NegY and NegX
            if (($this.NegY - $Number) -ge ($Number - $this.NegX))
            {
                $Distance = $this.currentring + ($Number - $this.NegX)
            }
            else
            {
                $Distance = $this.currentring + ($this.NegY - $Number)
            }
        }
        return $Distance
    }
}
$spiral = New-Object Spiral
$targetnumber = $InputContent
while(!$Spiral.testposition($targetnumber))
{
    $spiral.nextposition()
}
$spiral.getdistance($targetnumber)


$gridhash = @{}
$start = 1

0 1,0 1,1 0,1 -1,1 -1,0 -1,-1 0,-1 1,-1 2-1