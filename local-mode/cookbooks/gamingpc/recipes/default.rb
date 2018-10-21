#
# Cookbook:: gamingpc
# Recipe:: default
#
# Copyright:: 2018, Christopher Lazar, All Rights Reserved.

#######################################################################
### Installs Chocolatey since the chocolatey cookbook doesn't work. ###
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
  options "--ignore-checksums --force"
  package_name 'python'
end