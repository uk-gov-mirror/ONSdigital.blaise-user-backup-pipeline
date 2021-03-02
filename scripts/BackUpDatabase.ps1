###############################
# Backup Users pipeline script
###############################

scripts\tools\sqlite3 $env:DatabaseFileLocation ".clone Credentials-$(Get-Date -Format "dd-MM-yyyy-HH-mm").db"