// using functions
// This example show how we can take environment as an input parameter and use this in combination with a ternary operator
// An output is added using the 'friendly name' as a reference
// we also set the location for where to deploy to resource group location as default value for the parameter

@minLength(4)
@maxLength(24)
param storageAccountName string
param resourceLocation string = resourceGroup().location

@allowed([
  'prod'
  'test'
])
param environment string

var storageSku = environment == 'prod' ? 'Premium_LRS' : 'Standard_LRS' // if environment is prod use premium. If not use standard

resource storage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: toLower(storageAccountName) // force lowercase letters
  location: resourceLocation
  kind:'StorageV2'
  sku: {
    name: storageSku
  }
  properties: {
  }
}

resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = {
  name: '${storage.name}/default/mycontainer'
}


output strAccountId string = storage.id
