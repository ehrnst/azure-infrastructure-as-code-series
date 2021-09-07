// using functions
// This example show how we can take environment as an input parameter and use this in combination of an object variable.
// here we set the storage sku based on production or test environment. But insted of using ternary operator we use the object variable
// Also we removed the storage name and create it 'on the fly' to make sure we create a unique name based on our resource group
// containers is now created based on the storageSettings variable. We use a for-each loop to add the containers to our storage account.


@allowed([
  'prod'
  'test'
])
param environment string

var storageSettings = {
  prod: {
    sku: 'Premium_LRS'
    containers: [
      'logs'
      'images'
    ]
    publicAccess: false
  }
  test: {
    sku: 'Standard_LRS'
    containers: [
      'logs'
      'images'
    ]
    publicAccess: true
  }
}

var storageAccountName = 'str${uniqueString(resourceGroup().id)}' // generate a unique name with 'str' as a prefix.


resource storage 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: storageAccountName
  location: resourceGroup().location // use the same location for storage account as the resource group
  kind:'StorageV2'
  sku: {
    name: storageSettings[environment].sku // navigate our object variable and grab the sku based on input environment.
  }
  properties: {
    allowBlobPublicAccess: storageSettings[environment].publicAccess
    supportsHttpsTrafficOnly: true
  }
}

// add a loop to deploy multiple containers to our storage account
resource container 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-04-01' = [for containerName in storageSettings[environment].containers: {
  name: '${storage.name}/default/${containerName}'
}]


output strAccountId string = storage.id
