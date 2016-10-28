Framework "4.6"
properties {
    $solutionPath
}

task default -depends Clean

task Clean {
    Exec {MsBuild "$solutionPath" /t:Clean} 
}