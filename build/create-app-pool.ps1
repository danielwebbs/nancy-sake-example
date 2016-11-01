properties {
    $newAppPool
    $appPoolName
}

    Import-Module WebAdministration


task default -depends CreateAppPool

task CreateAppPool -depends InvokeRemoveExistingAppPool {
    Write-Host "Creating App Pool"
    New-Item IIS:\AppPools\$appPoolName
}

task InvokeRemoveExistingAppPool {
    Invoke-psake 'remove-existing-app-pool.ps1' -parameters @{'appPoolName' = $appPoolName}
}