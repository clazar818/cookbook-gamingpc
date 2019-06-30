#
# Cookbook:: gamingpc
# Recipe:: default
#
# Copyright:: 2018, Xypherius, All Rights Reserved.

#######################################################################
### Installs Chocolatey. ###
#######################################################################
powershell_script 'Install Chocolatey' do
  code <<-EOH
    iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
  EOH
  not_if 'Test-Path C:\\ProgramData\\chocolatey'
end


#######################################################################
### Installs Google Chrome. ###
#######################################################################
include_recipe 'chrome'

chrome 'custom_preferences' do
  parameters(
    homepage: 'https://google.com/'
  )
  action :master_preferences
end

#######################################################################
### Installs Spotify. ###
#######################################################################
chocolatey_package 'Spotify' do
  options '--ignore-checksums'
  package_name 'spotify'
end

#######################################################################
### Installs Battle.net - alongside World of Warcraft and Overwatch. ##
#######################################################################
chocolatey_package 'Battle.net' do
  options '--ignore-checksums'
  package_name 'battle.net'
end

powershell_script 'Install Overwatch' do
  code <<-EOH
    cd "C:\\Program Files (x86)\\Battle.net"
    ./battle.net.exe –-game=prometheus –-install  
  EOH
end

powershell_script 'Install World of Warcraft' do
  code <<-EOH
    cd "C:\\Program Files (x86)\\Battle.net"
    ./battle.net.exe –-game=Wow –-install  
  EOH
end


#######################################################################
### Installs Visual Studio Code ###
#######################################################################
chocolatey_package 'Visual Studio Code' do
  options '--ignore-checksums'
  package_name 'vscode'
end

template '~\\AppData\\Roaming\\Code\\User\\settings.json' do 
  source 'VSCodeSettings.erb' 
end 

#######################################################################
### MSIAfterburner ###
#######################################################################
chocolatey_package 'MSIAfterburner' do
  options '--ignore-checksums'
  package_name 'msiafterburner'
end

#######################################################################
### Installs  Malwarebytes Anti-Malware  ###
#######################################################################
chocolatey_package 'Malwarebytes Anti-Malware' do
  options '--ignore-checksums'
  package_name 'malwarebytes'
end

#######################################################################
### Installs  Discord  ###
#######################################################################
chocolatey_package 'Discord' do
  options '--ignore-checksums'
  package_name 'discord'
end

#######################################################################
### Installs  Steam  ###
#######################################################################
chocolatey_package 'Steam' do
  options '--ignore-checksums'
  package_name 'steam'
end


#######################################################################
### Installs  Origin  ###
#######################################################################
chocolatey_package 'Origin' do
  options '--ignore-checksums'
  package_name 'origin'
end


#######################################################################
### Installs  AVG Anti Virus  ###
#######################################################################
chocolatey_package 'AVG Anti Virus' do
  options '--ignore-checksums'
  package_name 'avgantivirusfree'
end

#######################################################################
### Creates a Windows System Restore Point  ###
#######################################################################

# Modifies Registry such that you can create system restore checkpoints every 5 hours (300mins) instead of every 24hrs
registry_key "HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\SystemRestore" do
  values [{
    name: 'SystemRestorePointCreationFrequency',
    type: :dword,
    data: 300
  }]
  action :create
end

powershell_script 'Create a System Restore Point' do
  code <<-EOH
    $DateTime = Get-Date -Format "yyyy-MM-dd-HH:mm"
    Checkpoint-Computer -Description "Post Chef Execution - $($DateTime)"  
  EOH
end
