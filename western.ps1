$TheWesternLandsHashes = @(
    @{
        Index = 1
        Name = "The Wreckage of the Sorcerer Aluminum Ivan's Devastation Machine"
        Descriptions = @(
            "Metal is covered in barnacles, rust and seaweed.",
            "Crashing of waves dig and clang against the structure.",
            "Many of the internal areas are powered and full of wondrous treasures and deadly monstrosities."
        )
    },
    @{
        Index = 2
        Name = "The Ruins of Santa Mo"
        Descriptions = @(
            "The ancient Earth city of Santa Monica",
            "Crumbled, smoldering, fetid.",
            "Small pockets of scavengers, mutants, raiders, and monsters dot the landscape.",
            "Secret lair for Gongfrath the Green. Up-and-coming Sorcerer about to make his epic debut with a Devastation Machine."
        )
    },
    @{
        Index = 3
        Name = "The Village of Route 66"
        Descriptions = @(
            "Houses made of metal shipping crates, village walls made of crushed, stacked cars.",
            
        )
    },
    @{
        Index = 4
        Name = "Shopping Mall Fortress of the Witch Grenzel"
        Descriptions = @(
            ""
        )
    },
    @{
        Index = 5
        Name = "Technothusiasts' Energy Farm"
        Descriptions = @(
            "Patchwork of Ancient Earth technology and stolen Stupendous Science devices run the farm’s equipment.",
            "The devices are run by water wheels and wind turbines which constantly generate energy. The energy is sold to Route 66 and Nukatomi Plaza.",
            "Technothusiasts are fringe humans with a fascination for Ancient Earth technology, to the extreme."
        )
    },
    @{
        Index = 6
        Name = "Nukatomi Plaza"
        Descriptions = @(
            "The last human kingdom.",
            "The ancient Earth of Los Angel"
        )
    },
    @{
        Index = 7
        Name = ""
        Descriptions = @(
            ""
        )
    },
    @{
        Index = 8
        Name = ""
        Descriptions = @(
            ""
        )
    },
    @{
        Index = 9
        Name = ""
        Descriptions = @(
            ""
        )
    },
    @{
        Index = 10
        Name = ""
        Descriptions = @(
            ""
        )
    },
    @{
        Index = 11
        Name = ""
        Descriptions = @(
            ""
        )
    },
    @{
        Index = 12
        Name = ""
        Descriptions = @(
            ""
        )
    },
    @{
        Index = 13
        Name = ""
        Descriptions = @(
            ""
        )
    }
)

class lands {
    [int32]$Index
    [string]$Name
    [array]$Descriptions
}

$TheWesternLands = New-Object "System.Collections.Generic.List[PSObject]"

$TheWesternLandsHashes.ForEach({
    $TheWesternLands.Add([lands]$PSItem)
})

