clear

Get-Process | Where-Object { $_.Name -ilike "c*" }

Get-Process | Where-Object { $_.Path -notmatch "system32" } | Select-Object ProcessName, Path | Format-Table `
-AutoSize -Wrap

Get-Service | Where-Object { $_.Status -eq "Stopped" }

if ($running -eq $true){
    try {Stop-Process -Name "chrome"} catch {Write-Output "Chrome Instance Already Closed"}
    $running = $false
}
else{
    Start-Process -FilePath "chrome" '-ArgumentList --start-fullscreen "https://www.champlain.edu"'
    $running = $true
}