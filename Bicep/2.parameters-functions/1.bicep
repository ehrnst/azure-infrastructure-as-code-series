// Adding input parameters.
// allowed parameter types are string, bool, integer, array, object. As well as secure types

param storageAccountName string

resource storage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName // use whats inputted
  location: 'westeurope'
  kind:'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    
  }
}
