// showing difference between implicit and explicit dependency
// In most cases we will use implicit dependency. But in some cases you might use dependsOn property.

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
  name: '${storage.name}/default/mycontainer' //implicit dependency
}


resource container2 'Microsoft.Storage/storageAccounts/blobServices/containers@2021-09-01' = {
  name: '${storage.name}/default/mycontainer2'
  dependsOn: [
    container // explicit dependency to the first container
  ]
}
