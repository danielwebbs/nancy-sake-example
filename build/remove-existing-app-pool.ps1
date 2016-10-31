properties {
    $appPoolName
}

task default -depends RemoveExistingAppPool

task RemoveExistingAppPool {
    Write-Host "Checking for existing App Pool"
    if(Test-Path IIS:\AppPools\$appPoolName) {
        Write-Host "App pool exists - removing"
        Remove-WebAppPool $appPoolName
        # Lists the current app pool directory
        gci IIS:\AppPools 
    }
}