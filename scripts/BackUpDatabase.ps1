###############################
# Backup Users pipeline script
###############################

Write-Host "VARS Write-Host: ($env:ENV_DATABASE_FILE_LOCATION)"
Write-Host "HEllo "
Write-Host "$ENV_BUCKET_NAME"

scripts/tools/sqlite3.exe $env:ENV_DATABASE_FILE_LOCATION ".clone Credentials-$(Get-Date -Format "dd-MM-yyyy-HH-mm-ss").db"
gsutil cp *.db gs://$env:ENV_BLAISE_BACKUP_BUCKET