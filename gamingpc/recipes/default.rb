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