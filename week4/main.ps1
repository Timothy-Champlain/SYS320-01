. (Join-Path $PSScriptRoot ApacheLogs.ps1)

$pullTable = getApacheLogs "index.html" " 200 " "Chrome"

$ipsoftens = $pulltable | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsoftens | Group ip
$counts | Select-Object Count, Name