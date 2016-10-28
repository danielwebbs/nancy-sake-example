Import-Module '.\psake-master\psake.psm1'

Invoke-psake 'build.ps1' -parameters @{'solutionPath' = '..\nancysake\nancysake.sln'}