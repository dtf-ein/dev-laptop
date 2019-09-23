# Install Ansible dependencies
Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
. choco feature enable -n=allowGlobalConfirmation
. choco install python
. choco install openssh --package-parameters='"/SSHServerFeature"'

# Set ssh to use `powershell` as its shell
Set-Itemproperty -path 'HKLM:\SOFTWARE\OpenSSH' -Name 'DefaultShell' -value 'C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe'

# Enable public key auth with SSH
$sshd_conf_path = "$env:programdata\ssh\sshd_config"
$sshd_conf = (Get-Content $Path)
$sshd_conf = $sshd_conf -Replace "Match Group administrators", "#Match Group administrators"
$sshd_conf = $sshd_conf -Replace "AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys", "#AuthorizedKeysFile __PROGRAMDATA__/ssh/administrators_authorized_keys"
Set-Content  -Path $sshd_conf_path -Value $sshd_conf
Add-Content  -Path $sshd_conf_path -Value "`nPubkeyAuthentication yes"

# TODO: `cat` control node's id_rsa.pub into %userprofile%\.ssh\authorized_keys

# Restart ssh service
Restart-Service -Name sshd -Force