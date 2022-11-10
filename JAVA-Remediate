# find all registered sources
$Sources = Get-WmiObject -Class Win32_NTEventLOgFile | 
  Select-Object FileName, Sources | 
  ForEach-Object -Begin { $hash = @{}} -Process { $hash[$_.FileName] = $_.Sources } -end { $Hash }

# list sources for application log
# $Sources["Application"]

#PowerShell script to uninstall all Java SE (JRE) versions on a computer
$currentbuild = "8.0.3410.10"
$uninstall32 = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -like "*Java*" -and $_.publisher -like "Oracle" } | select Displayname,UninstallString,displayversion,publisher | ?{$_.displayversion -ne $currentbuild}
$uninstall64 = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -like "*Java*" -and $_.publisher -like "Oracle" } | select Displayname,UninstallString,displayversion | ?{$_.displayversion -ne $currentbuild}

# Uninstall 32-bit Java versions
if ($uninstall32 -ne $null) {
foreach ($app32 in $uninstall32){
$app32str = $app32.UninstallString -Replace "msiexec.exe","" -Replace "/I","" -Replace "/X",""
$app32str = $app32str.Trim()
$app32msg = "Uninstalling Java SE... $app32"
Write-host $app32msg
start-process "msiexec.exe" -arg "/X $app32str /qb" -WindowStyle hidden -Wait
Write-EventLog -LogName "Application" -Source "Microsoft Intune Management Extension" -EventID 3001 -EntryType Information -Message $app32msg -Category 1 -RawData 10,20
} 
} else {
$app32msg = "Did not detect any 32-bit versions of Java to uninstall"
Write-EventLog -LogName "Application" -Source "Microsoft Intune Management Extension" -EventID 3001 -EntryType Information -Message $app32msg -Category 1 -RawData 10,20
write-host $app32msg}

# Uninstall 64-bit Java versions
if ($uninstall64 -ne $null) {
foreach ($app64 in $uninstall64){
$app64str = $app64.UninstallString -Replace "msiexec.exe", "" -Replace "/I", "" -Replace "/X", ""
$app64str = $app64str.Trim()
$app64msg = "Uninstalling Java ... $app64"
Write-host $app64msg
start-process "msiexec.exe" -arg "/X $app64str /qb" -WindowStyle hidden -Wait
Write-EventLog -LogName "Application" -Source "Microsoft Intune Management Extension" -EventID 3001 -EntryType Information -Message $app32msg -Category 1 -RawData 10,20
} 
} else {
$app64msg = "Did not detect any 64-bit versions of Java to uninstall"
Write-EventLog -LogName "Application" -Source "Microsoft Intune Management Extension" -EventID 3001 -EntryType Information -Message $app64msg -Category 1 -RawData 10,20
write-host $app64msg}
