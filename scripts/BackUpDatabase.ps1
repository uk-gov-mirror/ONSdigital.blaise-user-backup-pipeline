###############################
# Backup Users pipeline script
###############################

Write-Host "VARS Write-Host: ($env:ENV_DATABASE_FILE_LOCATION)"
Write-Host "HEllo "

scripts/tools/sqlite3.exe $env:ENV_DATABASE_FILE_LOCATION ".clone Credentials-$(Get-Date -Format "dd-MM-yyyy-HH-mm").db"
gsutil cp *.db gs://$ENV_BUCKET_NAME