###############################
# Backup Users pipeline script
###############################

Write-Host "Database location var: ($env:ENV_DATABASE_FILE_LOCATION)"
Write-Host "Backup Bucket var: ($env:ENV_BLAISE_BACKUP_BUCKET)"

$DB_FILES = Get-ChildItem $env:ENV_DATABASE_FILE_LOCATION -file *.db
Write-Host "Files to Backup - $DB_FILES"

$year       = Get-Date -Format "yyyy"
$month      = Get-Date -Format "MM"
$day        = Get-Date -Format "dd"
$date       = Get-Date -Format "dd-MM-yyyy"
$time       = Get-Date -Format "HH:mm:ss"
$servertime = "$(Hostname)_$time"

ForEach ($Result in $DB_FILES) {
    Write-Host "Backing up file - $Result"
    $fileName = $( $Result -replace '.db', $date )

    scripts/tools/sqlite3.exe $env:ENV_DATABASE_FILE_LOCATION$Result ".clone $Result"

    gsutil cp $Result gs://$env:ENV_BLAISE_BACKUP_BUCKET/$year/$month/$day/$servertime/

    Remove-Item $Result
    Write-Host "-------------------------------------"
}