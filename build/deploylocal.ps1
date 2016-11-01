
Framework "4.6"
Import-Module '.\psake-master\psake.psm1'

properties {
    $appPoolName = "nancysake"
    $websiteName = "nancysake"
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

task DeployLocal -depends Test,CreateWebsite {
    exec { msbuild "$PSScriptRoot\..\nancysake\nancysake\nancysake.csproj" /p:DeployOnBuild=true /p:PublishProfile="$($deploy[$configuration].PublishProfileName)" /p:Configuration=$configuration}

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

task InvokeCreateAppPool {
    Invoke-psake 'create-app-pool.ps1' -parameters @{'appPoolName' = $appPoolName}
}

task CreateWebsite -depends InvokeCreateAppPool {
    Invoke-psake 'createwebsite.ps1' -parameters @{'port' = 9090; 'ipAddress'='127.0.0.1'; 'deployDir' = $deployDir; 'appPoolName' = $appPoolName; 'websiteName' = $websiteName}
}
