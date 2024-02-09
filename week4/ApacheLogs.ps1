Clear
# Get-Content C:\xampp\apache\logs\access.log

# Get-Content C:\xampp\apache\logs\access.log -Tail 5

# Display only logs that contain 404 (not found) or 400 (bad request)
# Get-Content C:\xampp\apache\logs\access.log | Select-String ' 404',' 400 '

# Get-Content C:\xampp\apache\logs\access.log | Select-String " 200 " -NotMatch

# From every .log file in the directory, only get logs that contains the word 'error'
# $A = Get-ChildItem C:\xampp\apache\logs\*.log | Select-String 'error'
# $A[-5..-1]

# $notfounds = Get-Content C:\xampp\apache\logs\access.log | Select-String '404'

# $regex = [regex] "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"

# $ipsUnorganized = $regex.Matches($notfounds)
# $ipsUnorganized

# $ips = @()
# for($i=0; $i -lt $ipsUnorganized.count; $i++){
#  $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].value; }
# }
# $ipsoftens = $ips | Where-Object { $_.IP -ilike "10.*" }
# $counts = $ipsoftens | Group ip
# $counts | Select-Object Count, Name

function getApacheLogs($page,$statuscode,$browser){
 $snag = Get-Content C:\xampp\apache\logs\access.log
 $matchall = $snag | Select-String "$page" | Select-String $statuscode | Select-String $browser

 $regex = [regex] "\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}"
 $ipsUnorganized = $regex.Matches($matchall)

 $accessTable = @()
 for($i=0; $i -lt $matchall.count; $i++){
  $accessTable += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].value; `
                                     "Page" = $page; `
                                     "Status Code" = $statuscode; `
                                     "Browser" = $browser; `
                                     }
 }

 return $accessTable
}

getApacheLogs "index.html" " 200 " "Chrome"