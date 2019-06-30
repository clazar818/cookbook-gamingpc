# Installs Chocolatey if it doesn't exist
if (!(Test-Path 'C:\\ProgramData\\chocolatey')){
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else{
    Write-Host 'Chocolatey alaready exists!!! Moving on...' -Foregroundcolor Yellow
}

refreshenv

# Install ChefDK 
choco install chefdk -y
# Install Git CLI
choco install Git -y

refreshenv

$ChefWorkspace = '/workspace\Chef'

# Configure Git Workspace and Execute Chef Client, which will then configure the gaming PC.
if (!(Test-Path $ChefWorkspace)){
    mkdir $ChefWorkspace
}
else{
    Write-Host 'Coding Workspace already exists!! Moving on...' -Foregroundcolor Yellow
}

# Clone down the Git Repo which holds the gaming pc cookbook, it doesn't already exist:
if (!(Test-Path "$($ChefWorkspace)\cookbook-gamingpc")){
    git clone https://github.com/Xypherius/cookbook-gamingpc.git

}
else{
    Write-Host 'Coding Workspace already exists!! Moving on...' -Foregroundcolor Yellow
}


# Configuring Gaming PC
cd C:\Workspace\Chef\cookbook-gamingpc\exec-chef-locally
.\Execute-Cookbook-Run.ps1
