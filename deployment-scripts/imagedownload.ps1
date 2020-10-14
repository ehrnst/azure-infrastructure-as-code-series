# download a few images from google images and add them to a our storage account
[CmdletBinding()]
param (
    [Parameter()]
    [string]
    $searchString
)


$downloadFolder = $env:TEMP
Write-Verbose "searching for images of $searchString"
$googleImageSearch = (invoke-webrequest -Uri "https://www.google.com/search?q=$searchString&safe=active&source=lnms&tbm=isch").images `
| Where-Object {$_.src -like "https://encrypted*"} | Select-Object src -First 10
foreach ($result in $googleImageSearch) {
    
    $guid = (new-guid).Guid
    $imgName = "${downloadFolder}\$guid.png"
    Invoke-WebRequest -Uri $result.src -OutFile $imgName -UseBasicParsing
}
