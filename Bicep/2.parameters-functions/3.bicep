// using functions
// This example show how we can take environment as an input parameter and use this in combination of an object variable.
// here we set the storage sku based on production or test environment
// also added is an output, using the 'friendly name' as a reference

@minLength(4)
@maxLength(24)
param storageAccountName string

@allowed([
  'prod'
  'test'
])
param environment string

var storageSettings = {
  prod: {
    sku: 'Premium_LRS'
  }
  test: {
    sku: 'Standard_LRS'
  }
}


resource storage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: toLower(storageAccountName) // force lowercase letters
  location: resourceGroup().location // use the same location for storage account as the resource group
  kind:'StorageV2'
  sku: {
    name: storageSettings[environment].sku // navigate our object variable and grab the sku based on input environment.
  }
  properties: {
    
  }
}

output strAccountId string = storage.id
