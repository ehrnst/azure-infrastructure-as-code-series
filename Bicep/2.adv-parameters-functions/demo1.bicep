// using functions
// in this example we have set the minimum and maximum length allowed, as well as we force all letters to be lowercase.

@minLength(4)
@maxLength(24)
param storageAccountName string
param resourceLocation string = 'westeurope'


resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: toLower(storageAccountName) // force lowercase letters
  location: resourceLocation
  kind:'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2024-01-01' = {
  name: '${storage.name}/default/mycontainer'
}
