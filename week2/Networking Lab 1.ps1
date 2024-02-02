clear
# Get IPv4 Address from Ethernet0 Interface
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).IPAddress

# Get the IPv4 Prefix length
(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { `
$_.interfaceAlias -ilike "Ethernet0" }).PrefixLength

# Show what class there is of win32 library, sorted alphabetically
Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_net*" } | Sort-Object

# Get DHCP Server IP and hide the headers
Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" `
| select DHCPServer | Format-Table -HideTableHeaders

# Get DNS server ip and display only the first one
(Get-DnsClientServerAddress -AddressFamily IPv4 | `
Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).ServerAddresses[0]

# Choose a directory where you have some .ps1 files
cd $PSScriptRoot
list files based on the file name
$files=(Get-ChildItem)
for ($j=0; $j -le $files.Count ; $j++){
    if ($files[$j].Name -ilike "*ps1"){
        Write-Host $files[$j].Name
    }
}

# Create a folder if it does not already exist
$folderpath="PSScriptRoot\outfolder"
if ((Test-Path $folderpath) -eq $true){
    Write-Host "Folder Already Exists"
}
else{
    Write-Output "false"
    New-Item -ItemType "directory" -Path $folderpath
}

cd "C:/Users/champuser/Desktop/PSScriptRoot"
$files=(Get-ChildItem -File)
write-host $files
$folderPath = "C:/Users/champuser/Desktop/PSScriptRoot/outfolder/"
$filePath = Join-Path -Path $folderPath "out.csv"
# List all the files that have the extension ".ps1" and
# Save the results to out.csv file
$files | Where-Object { $_.Extension -eq ".ps1" } | `
Export-Csv -Path $filePath

# Without changing every directory (Don't go in outfolder), find
# every .csv file recursively and change their extensions to .log
# Recursively display all the files (not directories)
$files=Get-ChildItem -Recurse -File
$files | Rename-Item -NewName { $_.Name -replace '.csv', '.log' }
Get-ChildItem -Recurse -File

