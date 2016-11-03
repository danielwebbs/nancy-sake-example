
Import-Module '.\psake-master\psake.psm1'

properties {
    $serverName = "D899877"
    $server = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Server $serverName  
    $DBName = "NancyLocal"
    $microstSmo = "Microsoft.SqlServer.Management.Smo"
    $tableName = "BuildVersions"
    $dtvchar100 = [Microsoft.SqlServer.Management.Smo.Datatype]::NVarChar(100)
    $dtint = [Microsoft.SqlServer.Management.Smo.Datatype]::Int

}
Import-Module SQLPS 

task default -depends UpdateVersionNumber

task CreateDatabase {
    if ($null -eq $server.Databases[$DBName]) {
        $db = New-Object -TypeName Microsoft.SqlServer.Management.Smo.Database($server, $DBName)
        $db.Create()
    }    
    #Display databases
    $server.Databases | Select Name, Status, Owner, CreateDate
}

task CreateBuildVersionTable -depends CreateDatabase {
    $db = $server.Databases[$DBName]

     if($null -eq $db.Tables[$tableName]) {
         $buildVersionTable = New-Object ("$microstSmo.Table") ($server.Databases[$DBName], "BuildVersions", "dbo")

        #Create columns and primary key
        $colIdPk = New-Object ("$microstSmo.Column") ($buildVersionTable, "ID", $dtint)
        $colIdPk.Identity = $true
        $colIdPk.IdentitySeed = 1
        $colIdPk.IdentityIncrement = 1
        $buildVersionTable.Columns.Add($colIdPk)

        $colName = New-Object ("$microstSmo.Column") ($buildVersionTable, "BuildVersion", $dtvchar100)
        $colName.Nullable = $false
        $buildVersionTable.Columns.Add($colName)

        $buildVersionTable.Create()
        $db.ExecuteWithResults("INSERT INTO dbo.BuildVersions VALUES ('0.0')")
     } 
}

task UpdateVersionNumber -depends CreateBuildVersionTable {
    $db = $server.Databases[$DBName]
    $fetch = $db.ExecuteWithResults("Select TOP 1 * FROM dbo.BuildVersions ORDER BY BuildVersion DESC")
    $version = [double]$fetch.Tables.BuildVersion + 0.1
    $db.ExecuteWithResults("INSERT INTO dbo.BuildVersions VALUES ($version)")
}

