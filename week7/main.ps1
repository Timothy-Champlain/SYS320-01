. "c:\Users\champuser\SYS320-01\week6\Event-Logs.ps1"
. "c:\Users\champuser\SYS320-01\week7\configuration.ps1"
. "c:\Users\champuser\SYS320-01\week7\Email.ps1"
. "c:\Users\champuser\SYS320-01\week7\Scheduler.ps1"

clear

# Obtaining Configuration
$configuration = readConfiguration

# Obtaining at risk users
$Failed = getFailedLogins $configuration.Days

# Sending at risk users as email
SendAlertEmail ($Failed | Format-Table | Out-String)

# Setting the scripe to be run daily
ChooseTimeToRun($configuration.ExecutionTime)