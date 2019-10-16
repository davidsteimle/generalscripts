# This should be a success...

try{
    Write-Host $PSVersionTable.PSVersion
    try{
        Write-Host $PSVersionTable.PSEdition
    } catch {
        "Nested try failed..."
    }
} catch {
    "Parent try failed..."
}

# This should failed on nested try...

try{
    Write-Host $PSVersionTable.PSVersion
    try{
        1 / 0
    } catch {
        "Nested try failed..."
    }
} catch {
    "Parent try failed..."
}

#This should fail on parent try...

try{
    1 / 0
    try{
        Write-Host $PSVersionTable.PSVersion
    } catch {
        "Nested try failed..."
    }
} catch {
    "Parent try failed..."
}
