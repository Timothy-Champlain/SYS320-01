clear

function getPowerLogs($daysprior){
$poweronoffs = Get-EventLog system -Source EventLog -After (Get-Date).AddDays("-"+"$daysprior") | `
Where-Object {$_.EventID -ilike "600[5,6]"}

$poweronoffsTable = @() # Empty array to fill customly
for($i=0; $i -lt $poweronoffs.Count; $i++){

# Creating event property value
$event = ""
if($poweronoffs[$i].EventID -eq 6005) {$event="Startup"}
if($poweronoffs[$i].EventID -eq 6006) {$event="Shutdown"}

# Creating new user property value
#$SID = New-Object System.Security.Principal.SecurityIdentifier($poweronoff[$i].ReplacementStrings[1])
#$user = $SID.Translate([System.Security.Principal.NTAccount])

# Adding each new line (in form of a custom object) to our empty array
$poweronoffsTable += [pscustomobject]@{"Time" = $poweronoffs[$i].TimeGenerated; `
                                    "Id" = $poweronoffs[$i].EventID; `
                                    "Event" = $event; `
                                    "User" = "SYSTEM";
                                    }
}
return $poweronoffstable
}

getPowerLogs 50