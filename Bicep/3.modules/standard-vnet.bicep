// this module deploy a simple vnet and two subnets
// its on purpose left out of the main file

@allowed([
  'test'
  'prod'
])
param env string
param vnetName string = 'my-${env}-net'
param resourceLocation string = resourceGroup().location

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2021-08-01' = {
  name: vnetName
  location: resourceLocation
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/24'
      ]
    }
    subnets: [
      {
        name: 'sql-${env}-snet'
        properties: {
          addressPrefix: '10.0.0.128/26'
          serviceEndpoints: [
            {
              service: 'Microsoft.SQL'
            }
          ]
        }
      }
      {
        name: 'storage-${env}-snet'
        properties: {
          addressPrefix: '10.0.0.192/26'
          serviceEndpoints: [
            {
              service: 'Microsoft.Storage'
            }
          ]
        }
      }
    ]
  }
}
