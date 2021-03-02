###############################
# Backup Users pipeline script
###############################

sqlite3\sqlite3 $env:DatabaseFileLocation ".clone Credentials-$(Get-Date -Format "dd-MM-yyyy-HH-mm").db"