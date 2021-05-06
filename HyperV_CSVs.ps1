# --------------------------------------------------------------------------------------------------------------------
# Script: HyperV_CSVs.ps1 - Lista informações a respeito dos Volumes CSV (Cluster Shared Volume) em um cluster Hyper-v
# Contato: Paulo Roberto Sant´anna Cardoso (contato@paulosantanna.com)
# Compatibilidade: Windows Server 2008;Windows Server 2012
# Post no blog: https://paulosantanna.com/2018/11/09/hyper-v-powershell-para-obtencao-de-informacoes-dos-volumes-csv/
# Data: 09/11/2018
#---------------------------------------------------------------------------------------------------------------------

Import-Module FailoverClusters

$objs = @()

$csvs = Get-ClusterSharedVolume
foreach ( $csv in $csvs )
{
$csvinfos = $csv | select -Property Name -ExpandProperty SharedVolumeInfo
foreach ( $csvinfo in $csvinfos )
{
$obj = New-Object PSObject -Property @{
Name = $csv.Name
Path = $csvinfo.FriendlyVolumeName
Size = $csvinfo.Partition.Size
FreeSpace = $csvinfo.Partition.FreeSpace
UsedSpace = $csvinfo.Partition.UsedSpace
PercentFree = $csvinfo.Partition.PercentFree
}
$objs += $obj
}
}

$objs | ft -auto Name,Path,@{ Label = “Size(GB)” ; Expression = { “{0:N2}” -f ($_.Size/1024/1024/1024) } },@{ Label = “FreeSpace(GB)” ; Expression = { “{0:N2}” -f ($_.FreeSpace/1024/1024/1024) } },@{ Label = “UsedSpace(GB)” ; Expression = { “{0:N2}” -f ($_.UsedSpace/1024/1024/1024) } },@{ Label = “PercentFree” ; Expression = { “{0:N2}” -f ($_.PercentFree) } }