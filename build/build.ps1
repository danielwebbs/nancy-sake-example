Framework "4.6"
properties {
    $solutionPath
    $configuration
}

task default -depends Build

task Build -depends StartClean{
    Exec {MsBuild "$solutionPath" /p:Configuration=$configuration} 
}

task StartClean {
    Invoke-psake '.\clean.ps1' -parameters @{solutionPath = $solutionPath}
}