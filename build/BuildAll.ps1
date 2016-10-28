Import-Module '.\psake-master\psake.psm1'

Invoke-psake 'clean.ps1' -parameters @{'solutionPath' = '..\nancysake\nancysake.sln'}