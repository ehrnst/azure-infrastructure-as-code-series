// main bicep file. Creating a resource group and calling the sql module. The SQL module calls other modules just to add additional examples.
// pay attention to the main file target scope. it is set to 'subscription' which allow us to deploy resource groups. The SQL module call set scope to the rg

targetScope = 'subscription'

param env string
param resourceLocation string = deployment().location // using deployment location
param databaseName string
param serverLogin string
param serverLoginId string
param deployDate string = utcNow('yyyy-MM-dd') //used for tag only

var tags = {
  'owner': 'Martin Ehrnst'
  'purpose': 'NIC Bicep demo'
  'deploydate': deployDate
  'environment': env
}

resource sqlRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-bicep-demo3'
  location: resourceLocation
}

module sql 'sql.bicep' = {
  scope: sqlRg
  name: 'bicep-module-demo-sql'
  params: {
    databaseName: databaseName
    dbAdId: serverLoginId
    dbAdLoginName: serverLogin
    resourceLocation: resourceLocation
    connectToVnet: false // not mandatory for the module
    capacity: 6 // not mandatory for the module
    env: env
    tags: tags
  }
}
