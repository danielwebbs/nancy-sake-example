properties {
    $newAppPool
    $appPoolName
}

    Import-Module WebAdministration


task default -depends CreateAppPool

task CreateAppPool {
    Write-Host "Creating App Pool"
    Invoke-psake 'remove-existing-app-pool.ps1' -parameters @{'appPoolName' = $appPoolName}
    $newAppPool = New-Item IIS:\AppPools\$appPoolName
}
