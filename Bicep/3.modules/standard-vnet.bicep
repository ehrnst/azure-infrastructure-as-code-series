// this module deploy a simple vnet and two subnets
// its on purpose left out of the main file

param vnetName string
@allowed([
  'test'
  'prod'
])
param env string

resource virtualNetwork 'Microsoft.Network/virtualNetworks@2019-11-01' = {
  name: vnetName
  location: resourceGroup().location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.0.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'sql-${env}-net'
        properties: {
          addressPrefix: '10.0.0.0/28'
          serviceEndpoints: [
            {
              service: 'Microsoft.SQL'
            }
          ]
        }
      }
      {
        name: 'storage-${env}-net'
        properties: {
          addressPrefix: '10.0.1.0/28'
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
