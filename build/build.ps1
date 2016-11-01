Framework "4.6"
properties {
    $solutionPath
    $configuration
}

task default -depends Build

task Build -depends StartClean{
    Exec {MsBuild "$solutionPath"} 
}

task StartClean {
    Invoke-psake '.\clean.ps1' -parameters @{solutionPath = $solutionPath}
}