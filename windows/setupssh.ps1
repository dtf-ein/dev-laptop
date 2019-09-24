# Install Ansible dependencies
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
. choco feature enable -n=allowGlobalConfirmation
. choco install python
. choco install openssh --package-parameters='"/SSHServerFeature"'

# Set ssh to use `powershell` as its shell
Set-Itemproperty -path 'HKLM:\SOFTWARE\OpenSSH' -Name 'DefaultShell' -value 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'

# Restart ssh service
Restart-Service -Name sshd -Force