#!/usr/bin/powershell/pwsh

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
 Get wlan0 information from ifconfig. Original intent was to make wlan0 information available via bluetooth.
 
.DESCRIPTION 
 Get wlan0 information from a Linux system with ifconfig, Parses data into a PS Object with Ipv4 and Ipv6 records.
 
 Potential use: a cron job could be used to run the script on a schedule. If a headless system is connected to a 
 wifi source, and you cannot locate the address, this script's output could be accessed via Bluetooth (provided 
 pairing and a Bluetooth transfer server is set up). 
 
 This script was written for/on a system with the following properties:
 
 Name                           Value
 ----                           -----
 PSVersion                      6.2.0
 PSEdition                      Core
 GitCommitId                    6.2.0
 OS                             Linux 4.19.66-v7l+ #1253 SMP Thu Aug 15 12:02:08 BST 2019
 Platform                       Unix
 PSCompatibleVersions           {1.0, 2.0, 3.0, 4.0, 5.0, 5.1, 6.2}
 PSRemotingProtocolVersion      2.3
 SerializationVersion           1.1.0.1
 WSManStackVersion              3.0

#> 
Param(
    [System.IO.FileInfo]$Outfile = "~/.cache/obexd/wlan.txt" # The location and file to output data.
    ,
    [string]$Interface = "wlan0" # Name of interface to query.
)

# Get ifconfig information for wlan0
try{
    $Ifconfig = ifconfig $Interface
} catch {
    Write-Host "An error occurred!"
}

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
    try{ 
        [array]$Temp = $($PSItem.Split(" ")) 
    } catch { 
        Write-Host "An error occurred splitting $PSItem" 
    }
    try{ 
        $IpInfo.Add($Temp[0],$Temp[1]) 
    } catch {}
})

$Ifconfigv6Detail.ForEach({
    try{ 
        [array]$Temp = $($PSItem.Split(" ")) 
    } catch { 
        Write-Host "An error occurred splitting $PSItem" 
    }
    try{ 
        $IpInfo.Add($Temp[0],$Temp[1]) 
    } catch {}
})

$IpInfo = New-Object -TypeName IpInfo -Property $IpInfo

$IpInfo | Out-File -Path $Outfile -Force
