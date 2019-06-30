# Run the below script to install Chocolatey, ChefDK, and Git. The script will then call into Chef Client, to configure the gaming PC and install the DSC and required gaming packages. #

# Installs Chocolatey if it doesn't exist
if (!(Test-Path 'C:\\ProgramData\\chocolatey')){
    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}
else{
    Write-Host 'Chocolatey alaready exists!!! Moving on...' -Foregroundcolor Yellow
}

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

refreshenv

# Install ChefDK (Using force to install every time.)
choco install chefdk -y -force
# Install Git CLI (Using force to install every time.)
choco install Git -y -force

refreshenv

$ChefWorkspace = '/Workspace\Chef'

# Configure Git Workspace and Execute Chef Client, which will then configure the gaming PC.
if (!(Test-Path $ChefWorkspace)){
    mkdir $ChefWorkspace
}
else{
    Write-Host 'Coding Workspace already exists!! Moving on...' -Foregroundcolor Yellow
}

# Clone down the Git Repo which holds the gaming pc cookbook, it doesn't already exist:
if (!(Test-Path "$($ChefWorkspace)\cookbook-gamingpc")){
    cd $ChefWorkspace
    git clone https://github.com/Xypherius/cookbook-gamingpc.git
}
else{
    Write-Host 'Coding Workspace already exists!! Moving on...' -Foregroundcolor Yellow
}

# Configuring Gaming PC
cd "$($ChefWorkspace)\cookbook-gamingpc\exec-chef-locally"
berks vendor cookbooks
chef-client -z -o gamingpc