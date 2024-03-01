#$time = Read-Host -Prompt "Please enter the daily execution time of the script"
$timeRegex = [regex] "[1]{0,1}\d:[0-5]\d\s(A|P)M"
$matchTime = $timeRegex.Matches($time)
#write-host $matchTime
#if($match.count -eq 1){
#    Write-Host "input Successful"
#}
#else{
#    Write-Host "input failed"
#}
clear
function daysStuff(){
$days = Read-Host -Prompt "Please enter the number of days for which logs will be obtained"
$dayRegex = [regex] "\d{1,3}"
$dayntRegex = [regex] ".*\D.*"
$matchDay = $dayntRegex.Matches($days)
Write-Host "writing $matchDay"
if($matchDay.count -eq 0){
    return $true
}
else{
    return $false
}
}
daysStuff