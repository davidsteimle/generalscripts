function Test-IsAdmin {
<#
.SYNOPSIS
    Determines whether the current user is running under the context of an adminstrator
.NOTES
    https://www.powershellgallery.com/packages/MrAToolbox/1.3.4/Content/Test-IsAdmin.ps1
#>
    ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

}
