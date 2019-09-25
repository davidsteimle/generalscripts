<#PSScriptInfo

.VERSION 1.0

.GUID c12c129d-a521-499e-a730-c723f9dabcfe

.AUTHOR Steimle, David B.

.COMPANYNAME

.COPYRIGHT

.TAGS

.LICENSEURI

.PROJECTURI

.ICONURI

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS

.EXTERNALSCRIPTDEPENDENCIES

.RELEASENOTES


.PRIVATEDATA

#>

<# 

.SYNOPSIS
 Get wlan0 information from ifconfig.
 
.DESCRIPTION 
 Get wlan0 information from ifconfig. 

#> 
Param()

$Ifconfig = ifconfig wlan0

$Ipv4Regex = "inet\s[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"
$Ipv6Regex = "inet6\s[a-fA-F0-9]{1,4}::[a-fA-F0-9]{1,4}:[a-fA-F0-9]{1,4}:[a-fA-F0-9]{1,4}:[a-fA-F0-9]{1,4}"

$Ifconfig.ForEach({
    if($PSItem -match $Ipv4Regex){
        $Ipv4 =  $(([string]$PSItem.Trim()))
    } elseif($PSItem -match $Ipv6Regex){
        $Ipv6 = $(([string]$PSItem.Trim()))
    }
} )

[array]$Ifconfigv4Detail = $Ipv4.Split("  ")
[array]$Ifconfigv6Detail = $Ipv6.Split("  ")

class IpInfo{
    [System.Net.IPAddress]$inet
    [System.Net.IPAddress]$netmask
    [System.Net.IPAddress]$broadcast
    [System.Net.IPAddress]$inet6
    [int]$prefixlen
    [string]$scopeid
}

$IpInfo = @{}

$Ifconfigv4Detail.ForEach({
    [array]$Temp = $($PSItem.Split("  "))
    $IpInfo.Add($Temp[0],$Temp[1])
})

$Ifconfigv6Detail.ForEach({
    [array]$Temp = $($PSItem.Split("  "))
    $IpInfo.Add($Temp[0],$Temp[1])
})

$IpInfo = New-Object -TypeName IpInfo -Property $IpInfo
