// Adding input parameters.
// allowed parameter types are string, bool, integer, array, object. As well as secure types

param storageAccountName string
param resourceLocation string

resource storage 'Microsoft.Storage/storageAccounts@2021-09-01' = {
  name: storageAccountName // use whats inputted
  location: resourceLocation
  kind:'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  name: '${storage.name}/default/mycontainer' // since our storage account is referenced. An implicit dependency is set and the container will be provisioned after our storage account.
}
