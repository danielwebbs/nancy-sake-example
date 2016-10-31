Framework "4.6"
Import-Module '.\psake-master\psake.psm1'

properties {
    $appPoolName = "nancysake"
    $deployDir = "C:\Websites"

  $msDeployLocation = "C:\Program Files (x86)\IIS\Microsoft Web Deploy V3\"
  $configuration = "Debug"
  $deploy = @{
    "Debug" = @{
      "PublishProfileName" = "test";
      "BinaryLocation" = "bin\Debug";
      "ServerName" = "localhost";
      "SiteName" = "nancyTest";
      "ServiceFolder" = "C:\Websites";
        };
    }
}


task default -depends DeployLocal

task DeployLocal -depends CreateAppPool {
    Write-Host 'Creating new website'
    # To Be Refactored
    # New-Item -ItemType Directory -Path $deployDir
    New-Website -Name 'nancysake' -Port 9090 -IPAddress 127.0.0.1 -PhysicalPath $deployDir -ApplicationPool $appPoolName
    exec { msbuild "C:\_dev\nancy-build\nancysake\nancysake\nancysake.csproj" /p:AspnetCompilerPath="C:\windows\Microsoft.NET\Framework\v4.0.30319" /p:DeployOnBuild=true /p:PublishProfile="$($deploy[$configuration].PublishProfileName)" /p:Configuration=$configuration}

}

task Test -depends Build {
    $unitTestProject = Get-ChildItem -Filter "*Tests" -Directory "$PSScriptRoot\..\nancysake"

    $unitTestProjects | %{
    $assemblyPath = "$PSScriptRoot\..\nancysake\\$_\$($deploy[$configuration].BinaryLocation)\$_.dll"
      exec {& $testExecutable /testcontainer:$assemblyPath /category:Unit }
  }
 
  Remove-Item $PSScriptRoot\TestResults -Recurse
}

task Build {
    Invoke-psake 'build.ps1' -parameters @{'solutionPath' = '..\nancysake\nancysake.sln'}
}

task CreateAppPool {
    Invoke-psake 'create-app-pool.ps1' -parameters @{'appPoolName' = $appPoolName;}
}