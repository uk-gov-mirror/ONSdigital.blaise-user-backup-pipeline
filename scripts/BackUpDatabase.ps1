Write-Host "VM service account env var: ($env:ENV_VM_SERVICEACCOUNT)"
Write-Host "SQLite databases location env var: ($env:ENV_DATABASE_FILE_LOCATION)"
Write-Host "Backup bucket env var: ($env:ENV_BLAISE_BACKUP_BUCKET)"

Write-Host "Ensure we are authenticated with the correct service account"
gcloud config set account $env:ENV_VM_SERVICEACCOUNT

$DB_FILES = Get-ChildItem "$env:ENV_DATABASE_FILE_LOCATION" -file *.db
Write-Host "Files to Backup - $DB_FILES"

$year       = Get-Date -Format "yyyy"
$month      = Get-Date -Format "MM"
$day        = Get-Date -Format "dd"
$time       = Get-Date -Format "HH:mm:ss"
$servertime = "$(Hostname)_$time"

ForEach ($Result in $DB_FILES) {
    Write-Host "Backing up file - $Result"

    Write-Host "Cloning database file..."
    scripts/tools/sqlite3.exe "$env:ENV_DATABASE_FILE_LOCATION$Result" ".clone '$Result'"

    Write-Host "Uploading file to GCS..."
    Write-Host "Source file path: $Result"
    Write-Host "Destination GCS path: gs://$env:ENV_BLAISE_BACKUP_BUCKET/$year/$month/$day/$servertime/"
    gsutil cp -LiteralPath "$Result" "gs://$env:ENV_BLAISE_BACKUP_BUCKET/$year/$month/$day/$servertime/"

    Write-Host "Removing temporary file..."
    Remove-Item $Result
}
