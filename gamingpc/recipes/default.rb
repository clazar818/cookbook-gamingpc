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