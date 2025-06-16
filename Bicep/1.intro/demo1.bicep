// minimal Bicep template to deploy a Storage account in Azure

resource storage 'Microsoft.Storage/storageAccounts@2024-01-01' = {
  name: 'pfwjpaskdcpo'
  location: 'westeurope'
  kind:'StorageV2'
  sku: {
    name: 'Premium_LRS'
  }
  properties: {
    
  }
}
