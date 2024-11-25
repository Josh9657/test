# Exemple de script hébergé sur GitHub pour exécution avec Invoke-WebPSScript

Write-Host -ForegroundColor Green "Starting OSDCloud configuration..."

# Définir la politique d'exécution temporaire
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

# Installer ou mettre à jour le module OSD
try {
    Write-Host -ForegroundColor Green "Installing or updating OSD module..."
    Install-Module -Name OSD -Force -SkipPublisherCheck
    Write-Host -ForegroundColor Green "OSD module installed successfully."
} catch {
    Write-Host -ForegroundColor Red "Error installing OSD module: $($_.Exception.Message)"
}

# Importer le module
try {
    Write-Host -ForegroundColor Green "Importing OSD module..."
    Import-Module -Name OSD -Force
    Write-Host -ForegroundColor Green "OSD module imported successfully."
} catch {
    Write-Host -ForegroundColor Red "Error importing OSD module: $($_.Exception.Message)"
}

# Exécuter OSDCloud
try {
    Write-Host -ForegroundColor Green "Starting OSDCloud..."
    Start-OSDCloud -OSLanguage fr-fr -OSName "Windows 11 23H2 x64" -OSLicense Retail -OSEdition Pro -Zti
    Write-Host -ForegroundColor Green "OSDCloud executed successfully."
} catch {
    Write-Host -ForegroundColor Red "Error starting OSDCloud: $($_.Exception.Message)"
}

# Redémarrer si nécessaire
Write-Host -ForegroundColor Green "Restarting system in 5 seconds..."
Start-Sleep -Seconds 5
wpeutil reboot
