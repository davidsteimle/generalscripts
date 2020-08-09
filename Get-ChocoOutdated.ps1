function Get-ChocoOutdated{
    $TestChocoOutdated = [array]$(choco outdated)

    $OutdatedList = New-Object "System.Collections.Generic.List[PSObject]"

    $TestChocoOutdated.ForEach({
        if($PSItem -match "[\|]" -and $PSItem -notmatch "[\?]"){
            $ResultArray = $PSItem.Split('|')
            $ItemHash = [ordered]@{
                SoftwareName = $ResultArray[0]
                CurrentVersion = $ResultArray[1]
                AvailableVersion = $ResultArray[2]
                Pinned = $(if($ResultArray[3] -match 'true'){$true} else {$false})
            }
            $OutdatedList.Add($(New-Object psobject -Property $ItemHash))
        }
    })

    $OutdatedList
}
