# --------------------------------------------------------------------------------------------------------------------
# Script: HyperV_Shutdown_VMs.ps1 - Script to shutdown on all VMs
# Contact: Paulo Roberto Sant´anna Cardoso (contato@paulosantanna.com)
# Compatibility: Hyper-V
# Blog: paulosantanna.com
# Date: 02/01/2020
# ---------------------------------------------------------------------------------------------------------------------
[cmdletbinding()]
Param($vmhost = 'HYPERvHOST_NAME')
$runningVM = Get-VM -ComputerName $vmhost| where state -eq 'running'
foreach ($cn in $runningVM)
{Stop-VM $cn.name -asjob}