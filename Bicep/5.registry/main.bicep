// using module from ACR
// when user has access to pull images (acrPull) vscode will validate parameters against the module in ACR

var tags = {
  'owner': 'Martin Ehrnst'
  'purpose': 'Bicep demo'
}

module SQL 'br:acrbicepehrnst.azurecr.io/bicep/database/azsql:1' = {
  name: 'sqlDeploy'
  params: {
    databaseName: 'moduletest'
    dbAdId: '8fafa0fc-6947-4782-b3da-d65c25ca2157'
    dbAdLoginName: 'name@company.com'
    env: 'prod'
    tags: tags
  }
}
