# Global Variables
$WindowsAppMSIXDLLocation = "C:\temp\WindowsApp.msix"
$LogLocation = "C:\temp\Windows-App-Install-Logs"

# Install Windows App via Winget
function InstallWindowsAppMSIX {

    try { 
        # Install Windows App via MSIX
        Add-AppPackage -Path $WindowsAppMSIXDLLocation
    }
    Catch {
        # Error handling
        Write-Output $_.Exception.Message | Out-File $LogLocation += "Windows-App-MSIX-Install.log"
    }
}

#Download the Windows App via web request
function DownloadWindowsAppMSIX {
    # Variables
    $WindowsAppMSIXURL = "https://go.microsoft.com/fwlink/?linkid=2262633"
    try {
        Write-Output "Starting download of MSIX Windows App installer" 
        # Download the Windows App MSIX and place it in C:\temp
        Invoke-WebRequest -Uri $WindowsAppMSIXURL -OutFile $WindowsAppMSIXDLLocation
        #Start install of MSIX Windows App package
        InstallWindowsAppMSIX
    }
    Catch {
        # Error handling
        Write-Output $_.Exception.Message | Out-File $LogLocation += "Windows-App-MSIX-Download.log"
    }
}

#Download and Install the Windows App via Winget
function DownloadInstallWindowsAppWinget {
    try {
        Write-Output "Starting Install of Windows App via winget"
        winget install Microsoft.WindowsApp
    }
    Catch {
        # Error handling
        Write-Output $_.Exception.Message | Out-File $LogLocation += "Windows-App-Winget-Install.log"
        
        Write-Output "Installation of the Windows App has failed via winget check $LogLocation for more info. Attempting to Download and Install Windows App MSIX package"
        #Start download of MSIX Windows App package
        DownloadWindowsAppMSIX
    }
}

# Start download and Install of Windows App via winget
DownloadInstallWindowsAppWinget