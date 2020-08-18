
<#PSScriptInfo

.VERSION 1.0

.GUID 28bceb50-ebf4-4a91-8b53-45b9ee7f4b37

.AUTHOR Steimle, David B

.COMPANYNAME United States Postal Service, Desktop Packaging

.COPYRIGHT 

.TAGS 

.LICENSEURI 

.PROJECTURI 

.ICONURI 

.EXTERNALMODULEDEPENDENCIES 

.REQUIREDSCRIPTS 

.EXTERNALSCRIPTDEPENDENCIES 

.RELEASENOTES


#>

<# 

.DESCRIPTION 
 Find and replace putty.lnk where applicable. 

.EXAMPLE
 .\FixPuttyLink.ps1 -Verbose -Beta -TryItOut

 This will run against a list of systems marked as Beta, and take no action.

.EXAMPLE
 .\FixPuttyLink.ps1 -Verbose -Beta

 This will run against a list of systems marked as Beta.

.EXAMPLE
 .\FixPuttyLink.ps1 -Verbose

 This will run against the entire list of systems.

.EXAMPLE
 .\FixPuttyLink.ps1 -Verbose -TryItOut -SampleSize 1000

 This will run against the first 1000 systems in the list. Replace with any integer for a different sample.

#> 
[CmdletBinding()]
Param(
    [switch]$Beta,
    [switch]$TryItOut,
    [int32]$SampleSize = 0
)

$PuttyLnk = "\Users\Public\Desktop\putty.lnk" # Location of the link file.
$ReplacementLink = "C:\Users\MIGBZ7YJ0\putty.lnk"

$Sqlite3 = "C:\Users\MIGBZ7YJ0\bin\sqlite-tools-win32-x86-3320300\sqlite3.exe"
$Database = "C:\Users\MIGBZ7YJ0\bin\putty_problems\putty_lnk.db"
$CallDatabase = "$Sqlite3 $Database"

$Query = @"
.headers on
.mode csv
SELECT * FROM remediation;
"@

$Expression = "`"$Query`" | $CallDatabase"

$RemediationOutput = Invoke-Expression "$Expression | ConvertFrom-Csv"

$RemediationList = $RemediationOutput | Where-Object -Property Replaced -NotMatch 'True'

if($SampleSize -gt 0){
    $RemediationList = $RemediationList | Select-Object -First $SampleSize
}

if($Beta){
    $RemediationList = $RemediationList | Where-Object -Property Beta -Match 'True'
    Write-Verbose $("*"*50)
    Write-Verbose "  THIS IS A BETA RUN"
    Write-Verbose $("*"*50)
    $BetaCount = 0
}

$OfflineCount = 0
$NoWinRMCount = 0
$NoBadLink = 0
$NotReplaced = 0

$RemediationList.Foreach({
    [string]$Online = ""
    [string]$WinRM = ""
    [string]$Badlink = ""
    [string]$Replaced = ""
    $ComputerNameSplit = $($PSItem.Name).Split(".")
    $ComputerName = $ComputerNameSplit[0]
    $FullPutty = "\\$ComputerName\c$\$PuttyLnk"
    try{
        Test-Connection -ComputerName $ComputerName -Count 1 -ErrorAction Stop > $null
        $Online = 'True'
        try{
            Get-Item $FullPutty -ErrorAction Stop > $null
            $WinRM = 'True'
            if(Get-Content $FullPutty | Select-String '%windir%'){
                $BadLink = 'True'
                try{
                    if($TryItOut){
                        Get-Item $FullPutty > $null
                        Write-Verbose "Replace on $ComputerName needed"
                        $BetaCount++
                    } else {
                        Copy-Item $ReplacementLink -Destination $FullPutty -Force -ErrorAction Stop
                        $Replaced = 'True'
                    }
                } catch {
                    $Replaced = 'False'
                    $NotReplaced++
                }
            } else {
                $Badlink = 'False'
                $NoBadLink++
            }
        } catch {
            $WinRM = 'False'
            $NoWinRMCount++
        }
    } catch {
        $Online = 'False'
        $OfflineCount++
    }

    $UpdateQuery = "UPDATE remediation SET online='$Online',winrm='$WinRM',badlink='$BadLink',replaced='$Replaced' WHERE name='$($PSItem.Name)';"
    if($TryItOut){
        $UpdateQuery
        Write-Verbose "Sample Query"
    } else {
        Invoke-Expression "`"$UpdateQuery`" | $CallDatabase"
    }
})

If($Beta){
    Write-Host "$BetaCount systems need replacement."
    Write-Host "$($RemediationList.count) systems checked."
    Write-Host "$OfflineCount offline."
    Write-Host "$NoWinRMCount no WinRM."
    Write-Host "$NoBadLink no bad link."
    Write-Host "$NotReplaced not replaced."
}
