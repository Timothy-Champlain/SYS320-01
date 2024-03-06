clear

function obtainIOC(){
$page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.5/IOC.html

$trs=$page.ParsedHtml.body.getElementsByTagName("tr")

$FullTable = @()
for($i-1; $i -lt $trs.length; $i++){
    $tds = $trs[$i].getElementsByTagName("td")
    $FullTable += [pscustomobject]@{"Pattern" = $tds[0].innerText; `
                                    "Explanation" = $tds[1].innerText;
                                   }
}
return $FullTable
}
$FullTable = obtainIOC
# $FullTable


function apacheAccessLogs(){
$logsNotformatted = Get-Content C:\Users\champuser\Downloads\access.log
$tableRecords = @()
for($i=0; $i -lt $logsNotformatted.count; $i++){
    $words = $logsNotformatted[$i].Split(" ");
    $tableRecords += [pscustomobject]@{ "IP" = $words[0]; `
                                     "Time" = $words[3].Trim('['); `
                                     "Method" = $words[5].Trim('"'); `
                                     "Page" = $words[6]; `
                                     "Protocol" = $words[7]; `
                                     "Response" = $words[8]; `
                                     "Referrer" = $words[10]; ` }
}
return $tableRecords | Where-Object { $_.IP -ilike "10.*" }
}
$tableRecords = apacheAccessLogs
# $tableRecords | Format-Table -AutoSize -Wrap


function IOCLogs($FullTable, $tableRecords){
$testTable = $FullTable
Write-Host "Test Marker"
return $testTable
}

$someArray = IOCLogs
Write-Host $someArray
