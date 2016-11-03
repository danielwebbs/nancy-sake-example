
Framework "4.6"
Import-Module '.\psake-master\psake.psm1'

properties {
    $appPoolName = "DefaultAppPool"
    $websiteName = "Default Web Site"
    $deployDir = "C:\Websites\Nancy"

  $configuration = "Debug"
  $deploy = @{
    "Debug" = @{
      "PublishProfileName" = "test";
      "BinaryLocation" = "bin\Debug";
      "ServerName" = "localhost";
      "SiteName" = $websiteName
      "ServiceFolder" = "C:\Websites";
        };
    }
}


task default -depends DeployLocal

task DeployLocal -depends Test {
    exec { msbuild "$PSScriptRoot\..\nancysake\nancysake\nancysake.csproj"  /p:DeployOnBuild=true /p:PublishProfile="test" /p:Configuration=$configuration /p:AspnetCompilerPath="C:\windows\Microsoft.NET\Framework\v4.0.30319" /p:VisualStudioVersion=14.0 } 
    Invoke-psake "createdatabase.ps1"
}

task Test -depends Build {
    $unitTestProject = Get-ChildItem -Filter "*Tests" -Directory "$PSScriptRoot\..\nancysake"
    $unitTestProject | %{
      
    $assemblyPath = "$PSScriptRoot\..\nancysake\\$_\$($deploy[$configuration].BinaryLocation)\$_.dll"
      Exec { & "$PSScriptRoot\..\nancysake\packages\NUnit.ConsoleRunner.3.5.0\tools\nunit3-console.exe" $assemblyPath }
    }
}

task Build {
    Invoke-psake 'build.ps1' -parameters @{'solutionPath' = '..\nancysake\nancysake.sln'}
}

# task InvokeCreateAppPool {
#     Invoke-psake 'create-app-pool.ps1' -parameters @{'appPoolName' = $appPoolName}
# }

# task CreateWebsite {
#     Invoke-psake 'createwebsite.ps1' -parameters @{'port' = 9090; 'ipAddress'='127.0.0.1'; 'deployDir' = $deployDir; 'appPoolName' = $appPoolName; 'websiteName' = $websiteName}
# }
