// using functions
// in this example we have set the minimum and maximum length allowed, as well as we force all letters to be lowercase.

@minLength(4)
@maxLength(24)
param storageAccountName string


resource storage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: toLower(storageAccountName) // force lowercase letters
  location: 'westeurope'
  kind:'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = {
  name: '${storage.name}/default/mycontainer'
}
