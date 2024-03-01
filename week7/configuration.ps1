clear

function readConfiguration(){
    $configTable = @()
    #$filePath = C:\users\champuser\SYS320-01\week7\configuration.txt
    $lines = Get-Content -Path C:\users\champuser\SYS320-01\week7\configuration.txt
    for($i=0; $i -lt 1; $i++){
        $configTable += [pscustomobject]@{"Days"=$lines[0];`
                                          "ExecutionTime"=$lines[1];
        }
    }
    return $configTable
}

function changeConfiguration(){
    $lines = Get-Content -Path C:\users\champuser\SYS320-01\week7\configuration.txt
    $days = Read-Host -Prompt "Please enter the number of days for which logs will be obtained"
    #$dayRegex = [regex] "\d{1,3}"
    $dayntRegex = [regex] ".*\D.*"
    $matchDay = $dayntRegex.Matches($days)
    if($matchDay.count -eq 0){
        $time = Read-Host -Prompt "Please enter the daily execution time of the script"
        $timeRegex = [regex] "[1]{0,1}\d:[0-5]\d\s(A|P)M"
        $matchTime = $timeRegex.Matches($time)
        if($matchTime.count -eq 1){
            (Get-Content -Path C:\users\champuser\SYS320-01\week7\configuration.txt) |
                ForEach-Object {$_ -Replace $lines[0], $days} |
                ForEach-Object {$_ -Replace $lines[1], $matchTime} |
                    Set-Content -Path C:\users\champuser\SYS320-01\week7\configuration.txt

            Write-Host "Configuration Changed"
        }
        else{
        Write-Host "Input not accepted, please type the time in format digit:digitdigit AM/PM"
        }
    }
    else{
        Write-Host "Input not accepted, please type the day as an integer"
        }
}

function configurationMenu(){
    $Prompt  = "Please choose your operation:`n"
    $Prompt += "1 - Show Configuration`n"
    $Prompt += "2 - Change Configuration`n"
    $Prompt += "3 - Exit`n"

    $operation = $true

    while($operation){
    
        Write-Host $Prompt | Out-String
        $choice = Read-Host 

        if($choice -eq 3){
            Write-Host "Goodbye" | Out-String
            exit
            $operation = $false 
        }

        elseif($choice -eq 1){           
            readConfiguration | Out-String
        }

        elseif($choice -eq 2){            
            changeConfiguration | Out-String
        }

        else{
            Write-Host "input not accepted, please enter an integer from 1-3"
        }
    }
}
#configurationMenu