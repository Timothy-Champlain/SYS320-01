function getEnabledUsers(){
    $enabledUsers = Get-LocalUser | WhereObject { $_.Enabled -ilike "True"} | Select-Object Name, SID
    return $enabledUsers
}