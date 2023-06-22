# Import module
Install-Module -Name 'PSDocs.Azure' -Repository PSGallery -force;

$moduleDirectory = ".\modules"

$modules = Get-ChildItem -Path $moduleDirectory -Include *.bicep -Recurse

foreach ($module in $modules) {

    $testPath = Test-Path -Path ".\docs\modules\$docName.md" -PathType Leaf;
    $templateName = $module.BaseName;
    $docName = "$($templateName)";

    if ( $testPath -eq $false) {

        az bicep build --file $module.FullName --outfile $module.FullName.Replace('.bicep', '.json')

        # Scan for Azure template file recursively in the templates/ directory
        Get-AzDocTemplateFile -Path $module.DirectoryName | ForEach-Object {
            $template = Get-Item -Path $_.TemplateFile;
            # Generate markdown
            Invoke-PSDocument -Module PSDocs.Azure -OutputPath docs/modules -InputObject $template.FullName -InstanceName $docName -Culture en-US;

            Remove-Item $_.TemplateFile;

        }
    }

    else {
        Write-Host "Skipping $docName.md already exists";
    }
}
