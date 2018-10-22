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
    homepage: 'https://facebook.com/'
  )
  action :master_preferences
end


#######################################################################
### Installs Python. ###
#######################################################################
chocolatey_package 'Python' do
  options '--ignore-checksums'
  package_name 'python'
end

#######################################################################
### Installs Spotify. ###
#######################################################################
chocolatey_package 'Spotify' do
  options '--ignore-checksums'
  package_name 'spotify'
end

#######################################################################
### Installs Battle.net ###
#######################################################################
chocolatey_package 'Battle.net' do
  options '--ignore-checksums'
  package_name 'battle.net'
end


#######################################################################
### Installs Visual Studio Code ###
#######################################################################
chocolatey_package 'Visual Studio Code' do
  options '--ignore-checksums'
  package_name 'vscode'
end


#######################################################################
### Installs  Malwarebytes Anti-Malware  ###
#######################################################################
chocolatey_package 'Malwarebytes Anti-Malware' do
  options '--ignore-checksums'
  package_name 'malwarebytes'
end