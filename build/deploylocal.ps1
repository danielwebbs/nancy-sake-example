properties {
    $newAppPool = ""
    $appPoolName = "nancysake"
}

task default -depends DeployLocal

task DeployLocal -Depends CreateAppPool {
    Write-Host 'Creating new website'
    New-Website -name $appPoolName -PhysicalPath $deploy_dir -ApplicationPool $appPoolName -HostHeader $deploy_Url
}

task CreateAppPool {
    Invoke-psake 'create-app-pool.ps1' -parameters @{'appPoolName' = $appPoolName; 'newAppPool' = $newAppPool}
}