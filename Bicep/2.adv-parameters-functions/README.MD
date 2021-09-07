# Functions in Bicep

In this folder you will find a few bicep files with multiple `functions` to add more smartness to your code. For example we use objects combined with the inputted `environment` to configure a storage account. We also added a `loop` over an array of containers that will be added to the storage account.
Further we added a `parameter decorator` which dictates the length of the inputted name. Read more about parameter decorators [here](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/parameters?WT.mc_id=AZ-MVP-5003437#allowed-values)

Commonly used are `string` functions to manipulate resouce names. But theres a lot of functions built in to Bicep which you can read more about [here](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/bicep-functions?WT.mc_id=AZ-MVP-5003437)