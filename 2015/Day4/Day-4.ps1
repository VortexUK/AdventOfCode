$key = "ckczppom"
$md5 = new-object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider
$utf8 = new-object -TypeName System.Text.UTF8Encoding
$hashnotfound = $true
$count = 0
while ($hashnotfound)
{
    $hash = [System.BitConverter]::ToString($md5.ComputeHash($utf8.GetBytes("$key$count")))
    if ($hash -match "^00-00-00")
    {
        $hashnotfound = $false
        $count
    }
    $count++
}