# Global Variables
$RepoWebURL = "https://github.com/JamesBinghamBAMITS/Install-Windows-App/archive/refs/heads/main.zip"
$ZippedRepoLocation = "C:\temp\Get_installWindowsApp\Install-Windows-App.zip"
$RepoLocation = "C:\temp\Get_installWindowsApp\Install-Windows-App\"
$LogLocation  = "C:\temp\Get_installWindowsApp\Logs\"

# Get repo
function GetRepo {
    try{
        Invoke-WebRequest -Uri $RepoWebURL -OutFile $ZippedRepoLocation
    }
    Catch {
        # Error handling
        Write-Output "An error has occurred please see $LogLocation GetRepo.log"
        $FullLogPath = Join-Path -Path $LogLocation -ChildPath "GetRepo.log"
        $_.Exception.Message | Out-File -FilePath $FullLogPath -Append
    }   
}

# Extract Repo
function ExtractRepo {
    try {
        Expand-Archive -Path $ZippedRepoLocation -DestinationPath $RepoLocation
    }
    Catch {
        # Error handling
        Write-Output "An error has occurred please see $LogLocation ExtractRepo.log"
        Write-Output $_.Exception.Message | Out-File $LogLocation += "ExtractRepo.log"
    }
}

# Call CloneAndRunRepo
GetRepo