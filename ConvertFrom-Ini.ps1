
<#PSScriptInfo

.VERSION 1.0

.GUID 93bce953-148b-44b6-a5a8-19e1c9f3e081

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


#>

<# 

.DESCRIPTION 
 Convert a simple ini file to a powershell object. 

#> 
[CmdletBinding()]
Param()


function ConvertFrom-Ini{
    <# 
        .DESCRIPTION 
        Convert a simple ini file to a powershell object. 

        The ini file I am interested in goes like:

        ELEMENT1=VALUE1
        ELEMENT2=VALUE2
    #> 
    [CmdletBinding()]
    Param(
        [string]$InputFile # Path to ini file.
        ,
        [string]$Delimiter = "=" # Change if necessary
    )
    # Get content of your ini file as an array.
    [array]$MyIni = Get-Content $InputFile
    $MyElements = @()
    foreach($Ini in $MyIni){
        $MyElements += $Ini -split "$Delimiter"
    }
    $MyHash = @{}
    $i = 0
    while($i -lt $MyElements.Length){
        $MyHash.add("$($MyElements[$i])","$($MyElements[$i+1])")
        $i++
        $i++
    }
    $MyObject = New-Object -TypeName psobject -Property $MyHash
    return $MyObject
}
