###############################
# Backup Users pipeline script
###############################

Write-Host "VARS Write-Host: ($env:DatabaseFileLocation)"
Write-Host "HEllo "

scripts/tools/sqlite3.exe $env:DatabaseFileLocation ".clone Credentials-$(Get-Date -Format "dd-MM-yyyy-HH-mm").db"