[System.Int32]$PlayerCount,[System.Int32]$MarbleCount = (Get-Content -Path D:\git\AdventOfCode\2018\Day9\input.txt) -split '\s+' | Where-Object {$_ -match '^[0-9]+$'}
#[System.Int32]$PlayerCount,[System.Int32]$MarbleCount =13,7999
function Get-MarbleWinner($PlayerCount,$MarbleCount)
{
    [System.Collections.ArrayList]$MarbleCircle = @(0, 2, 1, 3)
    $CurrentPlayer = 3
    $MarblePosition = 3
    for ($CurrentMarble = 4; $CurrentMarble -lt $MarbleCount;$CurrentMarble++)
    {
        $CurrentPlayer = $CurrentMarble % $PlayerCount
        if ( $CurrentMarble % 23 -eq 0)
        {
            if ($MarblePosition -7 -lt 0)
            {
                $MarblePosition = $MarbleCircle.Count - (7-$MarblePosition)
            }
            else
            {
                $MarblePosition -= 7
            }
            $Playerscores[$CurrentPlayer]+= $CurrentMarble
            $Playerscores[$CurrentPlayer]+= $MarbleCircle[$MArblePosition]
            $MarbleCircle.RemoveAt($MarblePosition)
        }
        else
        {
            $MarblePosition = ($MarblePosition+2) % ($MarbleCircle.Count)
            $MarbleCircle.Insert($MarblePosition,$CurrentMarble)
        }
        if ($CurrentMarble % 50000 -eq 0)
        {
            Write-Host $CurrentMarble
        }
    }
    return ($playerscores.GetEnumerator() | sort value -Descending)[0].Value
}
Class LinkedListNode {
    [System.Int64]$Value
    [LinkedListNode]$Next
    [LinkedListNode]$Previous
    LinkedListNode([System.Int64]$Value) {
        $this.Value = $Value
    }
}
Class CircularLinkedList {
    [LinkedListNode]$Head  
    [System.Int64] $Count


    CircularLinkedList([System.Int64]$Start) {
        $this.Head = [LinkedListNode]::new($start)
        $this.Head.next = $this.Head
        $this.Head.previous = $this.Head
        $this.count = 1
    }

    [System.Void] InsertAfter([LinkedListNode]$Node, [System.Int64]$Value) {
        $newNode = [LinkedListNode]::new($Value) 
        $tmp = $node.next
        $node.next = $newNode
        $newNode.previous = $node
        $newNode.next = $tmp
        $tmp.previous = $newNode
        $this.count++
    }

    [System.Void] Delete([LinkedListNode]$node) {
        $prev = $node.previous
        $nex = $node.next
        $prev.next = $nex
        $nex.previous = $prev
        $this.Count--
    }

    [LinkedListNode] Rotate ([LinkedListNode]$Node,[System.Int32]$Num)
    {
        [System.Int32]$Move = $Num
        [LinkedListNode]$NewNode = $Node
        if ($Num -lt 0)
        {
            while ($Move -ne 0)
            {
                $NewNode = $NewNode.Previous
                $Move++
            }
        }
        if ($Num -gt 0)
        {
            while ($Move -ne 0)
            {
                $NewNode = $NewNode.Next
                $Move--
            }
        }
        return $NewNode
    }
}
function Get-BestcircleScore ($PlayerCount, $MarbleCount)
{
    $Circle = [CircularLinkedList]::new(0)
    [System.Int64[]]$playerScores = New-Object -TypeName 'System.Int64[]' -ArgumentList $PlayerCount

    $CurrentNode = $circle.Head
    $CurrentPlayer = 0
    for($CurrentMarble=1; $CurrentMarble -lt $MarbleCount; $CurrentMarble++) 
    {
        if(($CurrentMarble % 23) -eq 0) 
        {
            $playerScores[$CurrentPlayer % $PlayerCount] += [System.Int64]$CurrentMarble
            $CurrentNode = $CurrentNode.Previous.Previous.Previous.Previous.Previous.Previous
            $playerScores[$CurrentPlayer % $PlayerCount] += [System.Int64]($CurrentNode.Previous).Value
            $circle.Delete($CurrentNode.previous)
        } 
        else 
        {
            $Circle.InsertAfter($CurrentNode.next, $CurrentMarble)
            $CurrentNode = $CurrentNode.Next.Next
        }
        $CurrentPlayer++
    }
    return $playerScores | Sort-Object -Descending | Select -first 1
}
#region Part 1
[System.DateTime]$part1start = Get-date
[System.Int32]$Part1 = Get-BestcircleScore -PlayerCount $PlayerCount -MarbleCount $MarbleCount
[System.DateTime]$Part1End = Get-Date
#endregion
#region Part 2
[System.DateTime]$Part2Start = Get-date
[System.Int64]$Part2 = Get-BestcircleScore -PlayerCount $PlayerCount -MarbleCount ($MarbleCount * 100)
[System.DateTime]$Part2End = Get-Date
#endregion
Write-Host -Object "Answer to Part 1: $Part1 (Took $((New-TimeSpan -Start $part1start -End $Part1End).TotalMilliseconds) Milliseconds)" -ForegroundColor Yellow
Write-Host -Object "Answer to Part 2: $Part2 (Took $((New-TimeSpan -Start $Part2Start -End $part2end).TotalSeconds) Seconds)" -ForegroundColor Yellow