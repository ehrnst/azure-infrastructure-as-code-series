// bicep example
// you will need to compile this file in to a Json ARM template using 'bicep build'
// notice we specify a symbolic name within the temlpate 'storageAccount' this can be referenced.
// resource type is simplified and now includes the api version
// all properties defined within the curly brackets

// parameters

param storageAccountName string = 'demoBicep512' // this is a parameter with default value

param isProduction bool // boolean type parameter


// variables

var storageName = 'str${storageAccountName}' // this is concatination in bicep
var location = resourceGroup().location // same as in ARM template. resourceGroup functions

// resources
resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' = {
    name: toLower(storageName) // string interpolation supported
    location: location // we can reference parameter directly.
    kind: 'Storage'
    sku: {
        name: isProduction ? 'Standard_GRS' : 'Standard_LRS' // check wheather production environment is 'true' and enable GRS for prod resource
    }
}