// using module from ACR

var tags = {
  'owner': 'Martin Ehrnst'
  'purpose': 'Bicep demo'
}

module SQL 'br:acrbicepehrnst.azurecr.io/modules/azuresql/sql:v0.1' = {
  name: 'sqlDeploy'
  params: {
    databaseName: 'moduletest'
    dbAdId: '8776fb6e-5de0-408c-be03-c17a67b079d0'
    dbAdLoginName: 'name@company.com'
    env: 'prod'
    tags: tags
  }
}