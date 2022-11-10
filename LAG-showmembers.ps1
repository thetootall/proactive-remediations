    #Run this script prior to implementing Proactive Remediations to see members
    $administratorsGroup = ([ADSI]"WinNT://$env:COMPUTERNAME").psbase.children.find("Administrators")
    $administratorsGroupMembers = $administratorsGroup.psbase.invoke("Members")
    foreach ($administratorsGroupMember in $administratorsGroupMembers) {
        $administrator = $administratorsGroupMember.GetType().InvokeMember('Name','GetProperty',$null,$administratorsGroupMember,$null) 
        #Uncomment if you have multiple accounts and need to exclude a local user or account
        #if (($administrator -ne "Administrator") -and ($administrator -ne $currentUser)) {
        Write-host $administrator
        }
