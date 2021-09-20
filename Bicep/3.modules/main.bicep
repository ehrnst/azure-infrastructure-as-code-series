// main bicep file. Creating a resource group and calling the sql module. The SQL module calls other modules just to add additional examples.
// pay attention to the main file target scope. it is set to 'subscription' which allow us to deploy resource groups. The SQL module call set scope to the rg

targetScope = 'subscription'

param env string
param databaseName string
param serverLogin string
param serverLoginId string
param deployDate string = utcNow('yyyy-MM-dd') //used for tag only

var tags = {
  'owner': 'Marcel Zehner'
  'purpose': 'Bicep demo'
  'deploydate': deployDate
  'environment': env
}

var location = deployment().location // using deployment location

resource sqlRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-bicep-demo3'
  location: location
}

module sql 'sql.bicep' = {
  scope: sqlRg
  name: 'bicep-module-demo-sql'
  params: {
    databaseName: databaseName
    dbAdId: serverLoginId
    dbAdLoginName: serverLogin
    connectToVnet: true // not mandatory for the module
    capacity: 6 // not mandatory for the module
    env: env
    tags: tags
  }
}
