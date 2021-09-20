// This module is used to reference and link existing vnet/subnets
// can be used by multiple services by changing the code slightly

@allowed([
  'test'
  'prod'
])
param env string

@allowed([
  'sql'
])
param resourceType string

param resourceName string

param resourceSub string

param resourceRG string

var environmentConfig = {
  test: {
    vnetSubscription: '6dca9329-fb22-46cb-826c-e26edc8a4840' // test subscription
    vnetResourceGroup: 'rg-bicep-demo-vnet'
    vnet: 'my-${env}-vnet'
    subnets: {
      sqlsubnet: 'sql-${env}-net'
    }
  }
  prod: {
    vnetSubscription: '6dca9329-fb22-46cb-826c-e26edc8a4840' // prod subscription
    vnetResourceGroup: 'rg-bicep-demo-vnet'
    vnet: 'my-${env}-vnet'
    subnets: {
      sqlsubnet: 'sql-${env}-net'
    }
  }
}


resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: 'test'
}

// get existing subnets
resource sqlSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing = {
  name: '${environmentConfig[env].vnet}/${environmentConfig[env].subnets.sqlsubnet}'
  scope: resourceGroup(environmentConfig[env].vnetSubscription, environmentConfig[env].vnetResourceGroup)
}

// this one is deployed by the SQL module
resource sqlServer 'Microsoft.Sql/servers@2021-02-01-preview' existing = if (resourceType == 'sql') {
  name: resourceName
  scope: resourceGroup(resourceSub, resourceRG)
}

resource sqltoVCEnetBlue 'Microsoft.Sql/servers/virtualNetworkRules@2021-02-01-preview' = if (resourceType == 'sql') {
  name: '${sqlServer.name}/${env}-connection'
  properties: {
    virtualNetworkSubnetId: sqlSubnet.id
    ignoreMissingVnetServiceEndpoint: true
  }
  dependsOn: [
    sqlServer
  ]
}
