# https://twitter.com/dustin5977/status/1216747404843798530?s=20
$objSystemInfo= New-Object -ComObject "Microsoft.Update.SystemInfo"
    # Create the object
    $WindowsUpdateObj = [PSCustomObject]@{         
        Computer = $env:COMPUTERNAME
        RebootRequired = $objSystemInfo.RebootRequired
        ObjTimeStamp = (get-date)
    }

# https://twitter.com/dustin5977/status/1216747542895038466?s=20
$objInstaller=New-Object -ComObject "Microsoft.Update.Installer"
    # Create the object
    $WUInstallerStatusObj = [PSCustomObject]@{         
        Computer = $env:COMPUTERNAME
        IsBusy = $objInstaller.IsBusy
        ObjTimeStamp = (get-date)
    }
