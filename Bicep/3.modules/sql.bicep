// deploy a SQL server with additional features
// you will need to provide a group/user and corresponding login name and principal ID to be set as SQL administrator

@description('Provide a server name or run with default. (unique)')
param sqlServerName string = 'sql-${uniqueString(resourceGroup().id)}'

@allowed([
  'test'
  'prod'
])
@description('What environment are you deploying')
param env string

@description('The location of SQL server. Default to same as resource group')
param resourceLocation string = resourceGroup().location

@allowed([
  'generalPurpose'
  'businessCritical'
  'hyperScale'
])
@description('What DB type are you deploying. Default is generalPurpose')
param databaseType string = 'generalPurpose'

@description('Db capacity. Default is 2')
param capacity int = 2

param databaseName string

@allowed([
  'User'
  'Group'
])
@description('SQL Admin. AD group or user. Default is user')
param dbAdType string = 'User'

@description('Provide the DB login name. user.name@company.no, groupName@company.no')
param dbAdLoginName string

@description('Provide the object ID of the group or user which is SQL administrator')
param dbAdId string

@description('If you want to connect to the existing vnet set true. Default is false')
param connectToVnet bool = false

param tags object

var dbSkus = {
  GeneralPurpose: {
    name: 'GP_Gen5_${capacity}'
  }
  BusinessCritical: {
    name: 'BC_Gen5_${capacity}'
  }
  Hyperscale: {
    name: 'HS_Gen5_${capacity}'
  }
}

var storageName = replace('str${sqlServerName}', '-', '')

// storage account for defender and audits.
resource sqlStorageAccount 'Microsoft.Storage/storageAccounts@2021-04-01' = {
  name: take(toLower(storageName), 24)
  location: resourceLocation
  kind: 'StorageV2'
  properties: {
    allowBlobPublicAccess: false
    supportsHttpsTrafficOnly: true
    networkAcls: {
      defaultAction: 'Deny'
      bypass: 'AzureServices'
    }
  }
  sku: {
    name: 'Standard_LRS'
  }
  tags: tags
}

resource sqlServer 'Microsoft.Sql/servers@2020-11-01-preview' = {
  name: sqlServerName
  location: resourceLocation
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    publicNetworkAccess:'Enabled'
    minimalTlsVersion: '1.2'
    administrators:{
      azureADOnlyAuthentication: true
      administratorType: 'ActiveDirectory'
      tenantId: subscription().tenantId
      principalType: dbAdType
      login: dbAdLoginName
      sid: dbAdId
    }
  }
  tags: tags
}

resource sqlAudit 'Microsoft.Sql/servers/auditingSettings@2021-02-01-preview' = if (env == 'prod') {
  name: '${sqlServer.name}/default'
  properties: {
    state: 'Enabled'
    storageEndpoint: env == 'prod' ? '${sqlStorageAccount.properties.primaryEndpoints.blob}' : json('null')
    isAzureMonitorTargetEnabled: true
    storageAccountSubscriptionId: subscription().subscriptionId
    isStorageSecondaryKeyInUse: false
  }
  dependsOn: [
    rbac
  ]
}


resource sqlDb 'Microsoft.Sql/servers/databases@2021-02-01-preview' = {
  name: databaseName
  parent: sqlServer
  location: resourceLocation
  properties: {
    zoneRedundant: databaseType == 'hyperScale' ? false : true // hyperscale eq no zone redundancy
  }
  sku: {
    name: dbSkus[databaseType].name
  }
  tags: tags
}

resource dblongTermBackup 'Microsoft.Sql/servers/databases/backupLongTermRetentionPolicies@2021-02-01-preview' = if (databaseType != 'hyperScale' && env == 'prod') {
  name: 'default'
  parent: sqlDb
  properties: {
    monthlyRetention: 'P1M'
    weeklyRetention: 'P7W'
    yearlyRetention: 'P5Y'
    weekOfYear: 2
  }
}

resource dbShortTermBackup 'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies@2021-02-01-preview' = {
  name: 'default'
  parent: sqlDb
  properties: {
    retentionDays: 7
  }
}

// allow SQL server access to storage account
resource rbac 'Microsoft.Authorization/roleAssignments@2020-08-01-preview' = {
  name: guid(sqlServer.name, resourceGroup().id, sqlStorageAccount.id)
  scope: sqlStorageAccount
  properties: {
    principalType: 'ServicePrincipal'
    principalId: sqlServer.identity.principalId
    roleDefinitionId: '/subscriptions/${subscription().subscriptionId}/providers/Microsoft.Authorization/roleDefinitions/b7e6dc6d-f1e8-4753-8033-0f276bb0955b' //storage blob data owner
  }
}

resource advancedSecurity 'Microsoft.Sql/servers/securityAlertPolicies@2021-02-01-preview' = {
  name: '${sqlServer.name}/Default'
  properties: {
    state: 'Enabled'
  }
}

// azure defender for SQL
resource vulnerabilityAssessment 'Microsoft.Sql/servers/vulnerabilityAssessments@2021-02-01-preview' = {
  name: 'default'
  parent: sqlServer
  properties: {
    storageContainerPath: '${sqlStorageAccount.properties.primaryEndpoints.blob}vulnerability-assessment'
    recurringScans: {
      isEnabled: true
    }
  }
  dependsOn: [
    advancedSecurity
  ]
}


module existingSubnets 'existing-vnet.bicep' = if (connectToVnet) {
  name: 'connect-Subnet'
  params: {
    env: env
  }
  dependsOn: [
    sqlServer
  ]
}

resource sqlvnetRule 'Microsoft.Sql/servers/virtualNetworkRules@2021-02-01-preview' = if (connectToVnet) {
  name: '${sqlServer.name}/${env}-connection'
  properties: {
    virtualNetworkSubnetId: existingSubnets.outputs.subnets.sql
    ignoreMissingVnetServiceEndpoint: true
  }
}
