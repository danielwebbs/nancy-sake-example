properties {
    $websiteName
}

task default -depends RemoveWebsite

task RemoveWebsite {
     if(Test-path IIS:\Sites\$websiteName) {
        Write-Host 'Website exists, removing' + $websiteName -foregroundcolor "green"
        Remove-Website $websiteName
    }

}