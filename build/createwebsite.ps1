properties {
    $deployDir
    $appPoolName
    $websiteName
}

Import-Module WebAdministration

task default -depends CreateWebsite

task CreateWebsite -depends RemoveExistingWebsite {
    Write-Host 'Creating new website' -ForegroundColor 'Green'
    New-Website -Name $websiteName -PhysicalPath $deployDir -ApplicationPool $appPoolName 
}

task RemoveExistingWebsite {
    Invoke-psake 'removewebsite.ps1' -parameters @{'websiteName' = $websiteName}
}