properties {
    $deployDir
    $appPoolName
    $websiteName
}

Import-Module WebAdministration

task default -depends CreateVirtualDirectory

task CreateVirtualDirectory -depends CreateWebsite {
    New-WebVirtualDirectory -Name "nancysake" -Site $websiteName -PhysicalPath $deployDir 
}

task CreateWebsite -depends RemoveExistingWebsite {
    Write-Host 'Creating new website' -ForegroundColor 'Green'
    New-Website -Name $websiteName -PhysicalPath $deployDir -ApplicationPool $appPoolName
}

task RemoveExistingWebsite {
    Invoke-psake 'removewebsite.ps1' -parameters @{'websiteName' = $websiteName}
}