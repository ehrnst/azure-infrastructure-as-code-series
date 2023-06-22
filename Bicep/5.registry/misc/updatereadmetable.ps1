# update with latest version for readme
$OFS = [Environment]::NewLine
import-module Az.ContainerRegistry -Force
function ConvertTo-MarkDownTable {
    [CmdletBinding()] param(
        [Parameter(Position = 0, ValueFromPipeLine = $True)] $InputObject
    )
    Begin { $Index = 0 }
    Process {
        if ( !$Index++ ) {
            '|' + ($_.PSObject.Properties.Name -Join '|') + '|'
            '|' + ($_.PSObject.Properties.ForEach({ '-' }) -Join '|') + '|'
        }
        '|' + ($_.PSObject.Properties.Value -Join '|') + '|'
    }
}

$modules = Get-ChildItem .\modules -Include *.bicep -Recurse
$moduleTable = @()

foreach ($module in $modules) {
    $latestTag = ''
    $moduleName = $module.BaseName
    $moduleDirectory = $module.Directory.Name
    $registry = Get-AzContainerRegistryRepository -Name /modules/$moduleName -RegistryName azregistry
    $latestTag = $registry.LastUpdateTime.Split('T')[0]

    $bicepModule = [PSCustomObject]@{
        "`u{1F4AA} Name" = "$moduleName"
        "`u{1F4CE} URL" = "br:$($registry.Registry)/$($registry.ImageName):version"
        "`u{1F516} Latest version" = $latestTag
        "`u{1F4D6} Readme" = "/docs/modules/$($moduleName).md"
        "`u{1F453} Source" = "/modules/$moduleDirectory"
    }

    $moduleTable += $bicepModule
}

$newTable = $moduleTable | ConvertTo-MarkDownTable
# get current module table
[regex]$pattern = '(?s)(?<=<!--- Table --->\r?\n).*?(?=\r?\n<!--- End Table --->)'

$content = Get-Content .\docs\index.md -Raw
[Regex]::Replace($content, $pattern, $newTable) | Set-Content .\docs\index.md -NoNewline -Force
