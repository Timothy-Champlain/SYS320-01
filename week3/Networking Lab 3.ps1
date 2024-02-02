clear

# Get login and logoff records from Windows Events and save to a variable
# Get the last 14 days
# Get-EventLog system | where-object { $_.source -ilike "Microsoft-Windows-*"} | select source

function getAuthenticationLogs($daysago){

$loginouts = Get-EventLog system -source Microsoft-Windows-Winlogon -After (Get-Date).AddDays("-"+"$daysago")

$loginoutsTable = @() # Empty array to fill customly
for($i=0; $i -lt $loginouts.Count; $i++){

# Creating event property value
$event = ""
if($loginouts[$i].InstanceID -eq 7001) {$event="Logon"}
if($loginouts[$i].InstanceID -eq 7002) {$event="Logoff"}

# Creating new user property value
$SID = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1])
$user = $SID.Translate([System.Security.Principal.NTAccount])

# Adding each new line (in form of a custom object) to our empty array
$loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                    "Id" = $loginouts[$i].InstanceID; `
                                    "Event" = $event; `
                                    "User" = $user;
                                    }

} # End of for loop

return $loginoutsTable
}

$callFunc = getAuthenticationLogs 50
$callFunc