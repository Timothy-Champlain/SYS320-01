. (Join-Path $PSScriptRoot ScrapeClassData.ps1)

$FullTable = gatherClasses

$NewTable = daysTranslator $FullTable

# List all the classes of Instructor Furkan Paligu
#$NewTable | Select-Object "Class Code", Title, Instructor, Location, Days, "Time Start", "Time End" | `
#            where{ $_."Instructor" -ilike "Furkan*" }

#$NewTable | where-Object{ ($_.Location -ilike "JOYC 310") -and ($_.days -contains "Monday") } | `
#            sort-Object -Property "Time Start" | `
#            select "Time Start", "Time End", "Class Code"

$ITSInstructors = $FullTable | where-Object { ($_."Class Code" -ilike "SYS*") -or `
                                              ($_."Class Code" -ilike "NET*") -or `
                                              ($_."Class Code" -ilike "SEC*") -or `
                                              ($_."Class Code" -ilike "FOR*") -or `
                                              ($_."Class Code" -ilike "CSI*") -or `
                                              ($_."Class Code" -ilike "DAT*") } `
                             | sort-Object "Instructor" `
                             | select "Instructor" -Unique
#$ITSInstructors

$FullTable | where { $_.Instructor -in $ITSInstructors.Instructor } `
           | group-Object "Instructor" | Select-Object Count,Name | Sort-Object Count -Descending