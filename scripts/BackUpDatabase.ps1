###############################
# Backup Users pipeline script
###############################

$env:DatabaseFileLocation

scripts/tools/sqlite3.exe $env:DatabaseFileLocation ".clone Credentials-$(Get-Date -Format "dd-MM-yyyy-HH-mm").db"