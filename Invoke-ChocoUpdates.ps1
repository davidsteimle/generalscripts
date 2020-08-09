function Invoke-ChocoUpdates{
    <#PSScriptInfo

    .AUTHOR David B. Steimle

    #>

    <#

    .DESCRIPTION
    A function to update outdated chocolatey packages.

    #>

    [CmdletBinding()]
    Param()

    $TestChocoOutdated = Get-ChocoOutdated

    
}
