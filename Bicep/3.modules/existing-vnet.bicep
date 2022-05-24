// This module is used to reference and link existing vnet/subnets
// can be used by multiple services by changing the code slightly

@allowed([
  'test'
  'prod'
])
param env string

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


// get existing subnets
resource sqlSubnet 'Microsoft.Network/virtualNetworks/subnets@2021-02-01' existing = {
  name: '${environmentConfig[env].vnet}/${environmentConfig[env].subnets.sqlsubnet}'
  scope: resourceGroup(environmentConfig[env].vnetSubscription, environmentConfig[env].vnetResourceGroup)
}

// output the vnet id to use in another module
output subnets object = {
  sql: sqlSubnet.id
}
