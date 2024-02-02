. (Join-Path $PSScriptRoot "Networking Lab 3.ps1")
. (Join-Path $PSScriptRoot Shutdownstartup.ps1)

clear

$loginoutstable = getAuthenticationLogs 15
$loginoutstable

$shutdownstable = getPowerLogs 25
$loginoutstable