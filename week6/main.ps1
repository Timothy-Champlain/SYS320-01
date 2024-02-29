. (Join-Path $PSScriptRoot Users.ps1)
. (Join-Path $PSScriptRoot Event-Logs.ps1)

clear

$Prompt  = "Please choose your operation:`n"
$Prompt += "1 - List Enabled Users`n"
$Prompt += "2 - List Disabled Users`n"
$Prompt += "3 - Create a User`n"
$Prompt += "4 - Remove a User`n"
$Prompt += "5 - Enable a User`n"
$Prompt += "6 - Disable a User`n"
$Prompt += "7 - Get Log-In Logs`n"
$Prompt += "8 - Get Failed Log-In Logs`n"
$Prompt += "9 = Check At Risk Users `n"
$Prompt += "10 - Exit`n"



$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 


    if($choice -eq 10){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    elseif($choice -eq 1){
        $enabledUsers = getEnabledUsers
        Write-Host ($enabledUsers | Format-Table | Out-String)
    }

    elseif($choice -eq 2){
        $notEnabledUsers = getNotEnabledUsers
        Write-Host ($notEnabledUsers | Format-Table | Out-String)
    }


    # Create a user
    elseif($choice -eq 3){ 

        $name = Read-Host -Prompt "Please enter the username for the new user"
        
        $checking = checkUser $name
        
        if($checking){
            Write-Host "User: $name already exists" | Out-String
        }
        else{
            $password = Read-Host -Prompt "Please enter the password for the new user"
        
            $checkPass = checkPassword $password
            if($checkPass){
                $password = ConvertTo-SecureString $password -AsPlainText -Force
                createAUser $name $password

                Write-Host "User: $name is created." | Out-String
            }
            else{
                Write-Host "Password does not satisfy requirements"
            }
        }
        
    }


    # Remove a user
    elseif($choice -eq 4){

        $name = Read-Host -Prompt "Please enter the username for the user to be removed"

        $checkerDel = checkUser($name)
        if($checkerDel){
            removeAUser $name

            Write-Host "User: $name Removed." | Out-String
        }
        else{
            write-host "No such user: $name" | Out-String
        }
    }


    # Enable a user
    elseif($choice -eq 5){


        $name = Read-Host -Prompt "Please enter the username for the user to be enabled"

        $checkerEna = checkUser($name)
        if($checkerEna){
            enableAUser $name

            Write-Host "User: $name Enabled." | Out-String
        }
        else{
            write-host "No such user: $name" | Out-String
        }
    }


    # Disable a user
    elseif($choice -eq 6){

        $name = Read-Host -Prompt "Please enter the username for the user to be disabled"

        # TODO: Check the given username with the checkUser function.

        
        $checkerDis = checkUser($name)
        if($checkerDis){
            disableAUser $name

            Write-Host "User: $name Disabled." | Out-String
        }
        else{
            Write-Host "No such user: $name" | Out-String
        }
    }


    elseif($choice -eq 7){

        $name = Read-Host -Prompt "Please enter the username for the user logs"
        $checkerLogin = checkUser($name)
        if($checkerLogin){
            $days = Read-Host -Prompt "Please enter the number of days to check back in the logs"
                $userLogins = getLogInAndOffs $days
                Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
        }
        else{
            write-host "No such user: $name" | Out-String
        }
        
    }


    elseif($choice -eq 8){

        $name = Read-Host -Prompt "Please enter the username for the user's failed login logs"
        $checkerLogout = checkUser($name)
        if($checkerLogout){
            $days = Read-Host -Prompt "Please enter the number of days to check back in the logs"
            #if($days -inotlike "[0-9]{1,}"){
                #write-host "not a valid integer" | out-string
            #}
            #else{
                $userLogins = getFailedLogins $days
                Write-Host ($userLogins | Where-Object { $_.User -ilike "*$name"} | Format-Table | Out-String)
            #}
        }
        else{
            write-host "No such user: $name" | Out-String
        }
    }

    elseif($choice -eq 9){
        
        $days = Read-Host -Prompt "Please enter the number of days to check back in the logs"
        $failList = @()
        $userLogins = getFailedLogins $days
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

    
    # TODO: Create another choice "List at Risk Users" that
    #              - Lists all the users with more than 10 failed logins in the last <User Given> days.  
    #                (You might need to create some failed logins to test)
    #              - Do not forget to update prompt and option numbers
    
    # TODO: If user enters anything other than listed choices, e.g. a number that is not in the menu   
    #       or a character that should not be accepted. Give a proper message to the user and prompt again.
    
    else{
    Write-Host "input not accepted, please enter an integer from 1-10"
    }
}

