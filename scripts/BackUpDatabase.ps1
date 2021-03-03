###############################
# Backup Users pipeline script
###############################

Write-Host "Database location var: ($env:ENV_DATABASE_FILE_LOCATION)"
Write-Host "Backup Bucket var: ($env:ENV_BLAISE_BACKUP_BUCKET)"

scripts/tools/sqlite3.exe $env:ENV_DATABASE_FILE_LOCATION ".clone Credentials-$(Get-Date -Format "dd-MM-yyyy-HH-mm-ss").db"
gsutil cp *.db gs://$env:ENV_BLAISE_BACKUP_BUCKET