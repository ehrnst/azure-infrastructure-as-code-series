# download a few images from google images and add them to a our storage account
[CmdletBinding()]
param (
    [Parameter(Mandatory=$true)]
    [string]
    $searchString,

    [Parameter(Mandatory=$true)]
    [string]
    $strAccountName,

    [Parameter(Mandatory=$true)]
    [string]
    $strContainerName,

    [Parameter(Mandatory=$true)]
    [string]
    $strAccountKey,

    [Parameter(Mandatory=$true)]
    [string]
    $resourceGroupName
)

$ErrorActionPreference = 'Stop'

$downloadFolder = $env:TEMP
Write-Verbose "searching for images of $searchString"
$googleImageSearch = (invoke-webrequest -Uri "https://www.google.com/search?q=$searchString&safe=active&source=lnms&tbm=isch").images `
| Where-Object {$_.src -like "https://encrypted*"} | Select-Object src -First 10
foreach ($result in $googleImageSearch) {
    
    $guid = (new-guid).Guid
    $imgName = "${downloadFolder}\$guid.png"
    Invoke-WebRequest -Uri $result.src -OutFile $imgName -UseBasicParsing
}

# generate SAS token and upload to storage container
$strContext = New-AzStorageContext -StorageAccountName $strAccountName -StorageAccountKey $strAccountKey
$containerSasURI = New-AzStorageContainerSASToken -Context $strContext -ExpiryTime(get-date).AddSeconds(3600) -FullUri -Name $strContainerName -Permission rw

azcopy copy $downloadFolder $containerSasURI –-recursive
