// main bicep file. Creating a resource group and calling the sql module. The SQL module calls other modules just to add additional examples.
// pay attention to the main file target scope. it is set to 'subscription' which allow us to deploy resource groups. The SQL module call set scope to the rg

targetScope = 'subscription'

param env string
param databaseName string
param resourceLocation string = deployment().location // using deployment location
param serverLogin string
param serverLoginId string
param deployDate string = utcNow('yyyy-MM-dd') //used for tag only

var tags = {
  'owner': 'Marcel Zehner'
  'purpose': 'Bicep demo'
  'deploydate': deployDate
  'environment': env
}

resource sqlRg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-bicep-cicd'
  location: resourceLocation
}

module sql '../3.modules/sql.bicep' = {
  scope: sqlRg
  name: 'bicep-module-demo-sql-cicd'
  params: {
    databaseName: databaseName
    dbAdId: serverLoginId
    dbAdLoginName: serverLogin
    connectToVnet: true // not mandatory for the module
    capacity: 6 // not mandatory for the module
    env: env
    tags: tags
    resourceLocation: resourceLocation
  }
}
