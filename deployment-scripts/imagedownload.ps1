# download a few images from google images and add them to a our storage account
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $searchString,

    [Parameter()]
    [string]
    $strAccountName,

    [Parameter()]
    [string]
    $strContainerName,

    [Parameter()]
    [string]
    $strAccountKey,

    [Parameter()]
    [string]
    $resourceGroupName
)

$ErrorActionPreference = 'Stop'

# generate SAS token and upload to storage container
$strContext = New-AzStorageContext -StorageAccountName $strAccountName -StorageAccountKey $strAccountKey

$downloadFolder = $env:TEMP
Write-Verbose "searching for images of $searchString"
$googleImageSearch = (invoke-webrequest -Uri "https://www.google.com/search?q=$searchString&safe=active&source=lnms&tbm=isch").images `
| Where-Object {$_.src -like "https://encrypted*"} | Select-Object src -First 10
foreach ($result in $googleImageSearch) {
    
    $guid = (new-guid).Guid
    $imgName = "${downloadFolder}\$guid.png"
    Invoke-WebRequest -Uri $result.src -OutFile $imgName -UseBasicParsing
    
    try {
        write-verbose "Upload File..."
        $blobProperties = @{"ContentType" = "image/png"};
        Set-AzStorageBlobContent -Container $strContainerName -File $imgName -Blob "$guid.png" `
        -Context $strContext -BlobType "Block" -Properties $blobProperties -Force
    }
    catch {
        break
    }
}

$output = $"uploaded $($imagesearch.count)"
$DeploymentScriptOutputs['text'] = $output
