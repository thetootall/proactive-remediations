#Define variables
$currentUser = (Get-CimInstance Win32_ComputerSystem).Username -replace '.*\\'
#if you have a local group, add it here
#$localAdministrators = @("[YourGlobalAdminRoleSid]","[YourDeviceAdminRoleSid]") #Adjust to your local administrators

try {
    $administratorsGroup = ([ADSI]"WinNT://$env:COMPUTERNAME").psbase.children.find("Administrators")
    $administratorsGroupMembers = $administratorsGroup.psbase.invoke("Members")
    foreach ($administratorsGroupMember in $administratorsGroupMembers) {
        $administrator = $administratorsGroupMember.GetType().InvokeMember('Name','GetProperty',$null,$administratorsGroupMember,$null) 
        #Uncomment if you have multiple accounts and need to exclude a local user or account
        #if (($administrator -ne "Administrator") -and ($administrator -ne $currentUser)) {
        if ($administrator -ne "Administrator"){
            #$administratorsGroup.Remove("WinNT://$administrator")
            $msg =  "Proactive Remediation for Local Administrator Group membership successfully removed $administrator from Administrators group" 
            Write-host $msg
            Write-EventLog -LogName "Application" -Source "Microsoft Intune Management Extension" -EventID 3001 -EntryType Information -Message $msg -Category 1 -RawData 10,20
        }
    }
    Write-Host "Successfully remediated the local administrators"
}

catch {
    $errorMessage = $_.Exception.Message
    Write-Error $errorMessage
    exit 1
}
