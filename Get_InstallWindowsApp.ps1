# Global Variables
$GitAppID = "Microsoft.Git"
$InstalledApps = winget list --id $GitAppID
$GitWebURL = "https://github.com/JamesBinghamBAMITS/Install-Windows-App/archive/refs/heads/main.zip"
$RepoLocation = "C:\temp\Get_installWindowsApp\Install-Windows-App.zip"
$LogLocation  = "C:\temp\Get_installWindowsApp\Logs"

# Install Git
function InstallGit {
    if ($InstalledApps -like "*$GitAppID") {
        Write-Host "Git is already installed."
    } else {
        Write-Host "Git is not installed, Installing..."
        try {
            winget install $GitAppID
        }
        Catch {
            # Error handling
            Write-Output $_.Exception.Message | Out-File $LogLocation += "InstallGit.log"
        }
    }
}

# Get repo
function GetRepo {
    try{
        Invoke-WebRequest -Uri $GitWebURL -OutFile $RepoLocation
    }
    Catch {
        # Error handling
        Write-Output "An error has occurred please see $LogLocation GetRepo.log"
        Write-Output $_.Exception.Message | Out-File $LogLocation += "GetRepo.log"
    }   
}

function ExtractRepo {
    try {
        Expand-Archive -Path C:\SOURCE\PATH\TO\YOUR\ZIPPED.zip -DestinationPath C:\DESTINATION\PATH\UNZIP
    }
    Catch {
        # Error handling
        Write-Output "An error has occurred please see $LogLocation ExtractRepo.log"
        Write-Output $_.Exception.Message | Out-File $LogLocation += "ExtractRepo.log"
    }
}

# Call Install Git
InstallGit

# Call CloneAndRunRepo
GetRepo