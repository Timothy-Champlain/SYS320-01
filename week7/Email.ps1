﻿function SendAlertEmail($Body){
$From = "timothy.price@mymail.champlain.edu"
$To = "timothy.price@mymail.champlain.edu"
$Subject = "Suspicious Activity"

$Password = "cved gwpw eskr urvw" | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $From, $Password

Send-MailMessage -From $From -To $To -Subject $Subject -Body $Body -SmtpServer "smtp.gmail.com" `
-port 587 -UseSsl -Credential $Credential
}

# SendAlertEmail "Body of email"