![alt](https://docs.microsoft.com/en-us/learn/achievements/bicep/share-bicep-modules-using-private-registries.svg)
# Sharing bicep files using azure container registry (ACR)

With the release of Bicep CLI `0.4.1008` we where able to create a private registry for our modules.  
This is an easy way to share versioned modules within your organization.

For detailed information on how to create ACR and publish a module to your private registry, follow the [official documentation](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/private-module-registry?WT.mc_id=AZ-MVP-5003437).

```CLI
# publish a module

bicep publish path-to-file\module.bicep --target "br:acrname.azureacr.io/repositoryName/modulename:version"

```

The below shows how to consume the example SQL module from a private registry. Instead of referencing a local path, we use the full URI to the module with a version specified.

```Bicep
// consume module from private registry. ie from a main.bicep file

module sql 'br:acrname.azureacr.io/repositoryName/modulename:version' = {
  scope: rg
  name: 'sqldeploy'
  params: {
    databaseName:databaseName
    dbAdId: sqlAdminId
    dbAdLoginName: sqlLoginName
    env: env
    tags: tags
  }
}

```

## Microsoft public bicep registry

After Bicep `0.5.6` a public registry was introduced. You can find all modules [here](https://github.com/Azure/bicep-registry-modules#bicep-registry-modules)

to consume a module in the public registry use `br/public:category/name:version`. Everything else is the same as above.