. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        Get-Content C:\xampp\apache\logs\access.log -Tail 10 | Out-String
    }

    elseif($choice -eq 2){
        $userLogins = getFailedLogins $days
        Write-Host ($userLogins | Select -First 10 | Format-Table | Out-String)
    }

    elseif($choice -eq 3){
        $failList = @()
        $userLogins = getFailedLogins
        if($userLogins.count -le 0){
            Write-Host "No at risk users in the past $days days" | Out-String
        }
        else{
        #for($i=0; $i -lt $userLogins.count){
        #    $failList += [pscustomobject]@{ "User" = $userLogins[$i].User; }
        #}
        
        #Write-Host ($failList | Format-Table | Out-String)
        Write-Host ($userLogins | Format-Table | Out-String) # I wasn't able to get it to write into a list, sorry
        }
    }

    elseif($choice -eq 4){
        if ($running -eq $true){
            try {Stop-Process -Name "chrome"} catch {Write-Host "Chrome Instance Already Closed"}
            $running = $false
        }
        else{
            Start-Process -FilePath "chrome" '-ArgumentList --start-fullscreen "https://www.champlain.edu"'
            $running = $true
        }
        Out-String
    }

    else{
        Write-Host "input not accepted, please enter an integer from 1-5"
    }
}