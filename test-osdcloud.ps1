# Créer un dossier pour stocker les logs
$LogDirectory = "X:\Logs"
if (-not (Test-Path -Path $LogDirectory)) {
    New-Item -ItemType Directory -Path $LogDirectory
}

# Démarrer une transcription pour capturer toutes les sorties
$LogFile = Join-Path -Path $LogDirectory -ChildPath "OSDCloud_Log.txt"
Start-Transcript -Path $LogFile -Append

# Debug pour afficher que le script a démarré
Write-Host -ForegroundColor Green "Starting OSDCloud Configuration Script"

# Définir une politique d'exécution temporaire
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Installer le module OSD
try {
    Write-Host -ForegroundColor Green "Installing or updating OSD module..."
    Install-Module -Name OSD -Force -SkipPublisherCheck
    Write-Host -ForegroundColor Green "OSD module installed successfully."
} catch {
    Write-Host -ForegroundColor Red "Error during OSD module installation: $($_.Exception.Message)"
}

# Importer le module
try {
    Write-Host -ForegroundColor Green "Importing OSD module..."
    Import-Module -Name OSD -Force
    Write-Host -ForegroundColor Green "OSD module imported successfully."
} catch {
    Write-Host -ForegroundColor Red "Error during OSD module import: $($_.Exception.Message)"
}

# Démarrer OSDCloud
try {
    Write-Host -ForegroundColor Green "Starting OSDCloud..."
    Start-OSDCloud -OSLanguage fr-fr -OSName "Windows 11 23H2 x64" -OSLicense Retail -OSEdition Pro -Zti
    Write-Host -ForegroundColor Green "OSDCloud executed successfully."
} catch {
    Write-Host -ForegroundColor Red "Error during OSDCloud execution: $($_.Exception.Message)"
}

# Redémarrage après exécution
Write-Host -ForegroundColor Green "Restarting system in 5 seconds..."
Start-Sleep -Seconds 5
wpeutil reboot

Stop-Transcript
