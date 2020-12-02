# Try Try False Success

Ran by this in a script. Simplifying to make an error always happen.

Script has a function that tries to do a thing...

```powershell
function Test-DivideByZero {
    try{
        Invoke-Command -ScriptBlock { 1/0 } -ErrorAction Stop
        Write-Output "function success"
    } catch {
        Write-Output "function error"
    }
}
```

Then it calls the function within a ``try/catch``...

```powershell
try{
    Test-DivideByZero
    Write-Output "function call success"
} catch {
    Write-Output "function call error"
}
```

Running the code above yields:

```
function error
function call success
```

The real problem however, arises when a decision is made based on the function call rather than function results:

```powershell
function Test-DivideByZero {
    try{
        Invoke-Command -ScriptBlock { 1/0 } -ErrorAction Stop
        Write-Output "function success"
    } catch {
        Write-Output "function error"
    }
}

try{
    Test-DivideByZero
    Write-Output "function call success"
    $Success = $true
} catch {
    Write-Output "function call error"
    $Success = $false
}

Write-Output "Success = $Success"
```

Because we had no error in calling ``Test-DivideByZero`` success is ``$true``.

The better way to do this is to evaluate the result of the function.

```powershell
function Test-DivideByZero {
    try{
        Invoke-Command -ScriptBlock { 1/0 } -ErrorAction Stop
        $true
    } catch {
        $false
    }
}

if(Test-DivideByZero){
    $Success = $true
} else {
    $Success = $false
}

Write-Output "Success = $Success"
```

Which returns:

```
Success = False
```
