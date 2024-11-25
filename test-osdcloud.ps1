Write-Host -ForegroundColor Green "Starting OSDCloud ZTI"
Start-Sleep -Seconds 3

# Désactiver les vérifications de signature temporairement
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force

Write-Host -ForegroundColor Yellow "Custom Debug"

# Vérification et installation du module OSD
if (Get-Module -Name OSD -ListAvailable) {
    Write-Host -ForegroundColor Yellow "OSD Module already available, skipping installation."
} else {
    Write-Host -ForegroundColor Green "Installing OSD Module..."
    Install-Module -Name OSD -Force -SkipPublisherCheck
}

Write-Host -ForegroundColor Green "Importing OSD Powershell Module"
if (-not (Get-Module -Name OSD)) {
    Import-Module -Name OSD -Force
} else {
    Write-Host -ForegroundColor Yellow "OSD Module already loaded."
}

# Débogage pour éviter l'exécution automatique
$debugMode = $true  # Passez à $false pour activer l'exécution automatique

if ($debugMode) {
    Write-Host -ForegroundColor Yellow "Debug mode enabled: Skipping Start-OSDCloud"
} else {
    Write-Host -ForegroundColor Green "Starting OSDCloud..."
    Start-OSDCloud -OSLanguage fr-fr -OSName "Windows 11 23H2 x64" -OSLicense Retail -OSEdition Pro -Zti
}

# Empêcher le redémarrage automatique en mode debug
if ($debugMode) {
    Write-Host -ForegroundColor Yellow "Debug mode enabled: Skipping reboot"
} else {
    Write-Host -ForegroundColor Green "Restarting..."
    Start-Sleep -Seconds 5
    wpeutil reboot
}
