# Intro. Comparing ARM  templates and Bicep

Comparing the two templates. ARM and Bicep. You can see it greatly reduce the number of characters you need to write. Bicep abstract most of the complexity we know from ARM templates without sacrificing any functionality.
During deployment, Bicep will convert your Bicep file in to an ARM template.

In the example below you can see how much complexity is stripped when declaring a variable

```JSON
"variables" : {
    "variable1": "value1"
}
```

```Bicep
var variable1 = "value1"
```

Another example showing how lighthweight Bicep is compared to the YAML based ARM templates is references. Referencing in ARM requires you to structure a bracket type expression `[...]` where as Bicep allow you to reference a resource with a `symbolic` name. A friendly name only used inside your template.

The two examples below show how to reference the full resource id of a storage account. The files for deploying the accounts is in this same folder

```JSON
[resourceId('Microsoft.Storage/storageAccounts', 'pfwjpaskdcpo')] // referencing storage account ID with JSON Based ARM
```

```Bicep
storage.id // reference the storage account ID within Bicep, using the deployment symbolic name
```
## Compile and decompile

During deployment Bicep will compile an ARM template from your file. This is because under the hood, JSON based ARM templates is what Azure Resource Manager understand. Bicep abstract this for you, but you can however build ARM templates from your Bicep files, and even the other way around, decompiling an ARM template into Bicep.

> You do not have to manually compile Bicep files before deploying. We provided this just for reference.

```PowerShell
# Build arm template from Bicep

Az Bicep build --file main.json

# Take existing ARM template and convert it to Bicep

Az Bicep decompile --file azure.deploy.json
```

## Bicep tooling

- Install vs code extension
- [Install Bicep CLI and/or PowerShell ](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/install?WT.mc_id=AZ-MVP-5003437)
