#building scripts https://sysmansquad.com/2020/07/07/intune-autopilot-proactive-remediation/
#Validate versions of Java and uninstalling old ones

#update this variable for older builds
$currentbuild = "8.0.3410.10"

try{
#processing quicker = http://woshub.com/java-version-check-update-remove-via-powershell/
$jre32_installed = gci "HKLM:\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -like "*Java*" -and $_.publisher -like "Oracle" } | select Displayname,UninstallString,displayversion,publisher | ?{$_.displayversion -ne $currentbuild}
$jre64_installed = gci "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall" | foreach { gp $_.PSPath } | ? { $_ -like "*Java*" -and $_.publisher -like "Oracle" } | select Displayname,UninstallString,displayversion | ?{$_.displayversion -ne $currentbuild}

#Write-host $jre32_installed
#Write-host $jre64_installed

    #check for 32bit versions
    if (($jre32_installed -ne $null))
    {
        #Below necessary for Intune as of 10/2019 will only remediate Exit Code 1
        $jre32check = "Yes"
    }
    else{
        #No versions of Java found, do not remediate     
        $jre32check = "No"
    }  

    #check for 64bit versions
    if (($jre64_installed -ne $null))
    {
        #Below necessary for Intune as of 10/2019 will only remediate Exit Code 1
        $jre64check = "Yes"
    }
    else{
        #No versions of Java found, do not remediate     
        $jre64check = "No"
    }  

    #check for 64bit versions
	Write-host $jre32check
	Write-host $jre64check
    if (($jre32check -eq "No") -and ($jre64check -eq "No"))
    {
        #No versions of Java found, do not remediate     
        exit 0
    }
    else{
        #Below necessary for Intune as of 10/2019 will only remediate Exit Code 1
        $errMsg = "Start remediation: 32bit:$jre32check / 64bit:$jre64check"
        Return $errMsg
        exit 1

    }  
} 
catch{
    $errMsg = $_.Exception.Message
    Write-Error $errMsg
    exit 1
    }
