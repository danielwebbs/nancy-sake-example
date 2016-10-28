properties {
    $solutionPath
}

task default -depends Clean

task Clean {
    Exec {MsBuild "$solutionPath"} 
}