$length = 56
$characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890'
$password = -join ((1..$length) | ForEach-Object { Get-Random -Maximum $characters.length | ForEach-Object { $characters[$_] } })
Write-Output $password