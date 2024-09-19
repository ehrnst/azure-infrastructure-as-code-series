# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
sqlServerName  | No       | Provide a server name or run with default. (unique)
env            | Yes      | What environment are you deploying
resourceLocation | No       | The location of SQL server. Default to same as resource group
databaseType   | No       | What DB type are you deploying. Default is generalPurpose
capacity       | No       | Db capacity. Default is 2
databaseName   | Yes      |
dbAdType       | No       | SQL Admin. AD group or user. Default is user
dbAdLoginName  | Yes      | Provide the DB login name. user.name@company.no, groupName@company.no
dbAdId         | Yes      | Provide the object ID of the group or user which is SQL administrator
connectToVnet  | No       | If you want to connect to the existing vnet set true. Default is false
tags           | Yes      |

### sqlServerName

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Provide a server name or run with default. (unique)

- Default value: `[format('sql-{0}', uniqueString(resourceGroup().id))]`

### env

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

What environment are you deploying

- Allowed values: `test`, `prod`

### resourceLocation

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

The location of SQL server. Default to same as resource group

- Default value: `[resourceGroup().location]`

### databaseType

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

What DB type are you deploying. Default is generalPurpose

- Default value: `serverless`

- Allowed values: `serverless`, `generalPurpose`, `businessCritical`, `hyperScale`

### capacity

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

Db capacity. Default is 2

- Default value: `2`

### databaseName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



### dbAdType

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

SQL Admin. AD group or user. Default is user

- Default value: `User`

- Allowed values: `User`, `Group`

### dbAdLoginName

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Provide the DB login name. user.name@company.no, groupName@company.no

### dbAdId

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)

Provide the object ID of the group or user which is SQL administrator

### connectToVnet

![Parameter Setting](https://img.shields.io/badge/parameter-optional-green?style=flat-square)

If you want to connect to the existing vnet set true. Default is false

- Default value: `True`

### tags

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Bicep/3.modules/sql.json"
    },
    "parameters": {
        "sqlServerName": {
            "value": "[format('sql-{0}', uniqueString(resourceGroup().id))]"
        },
        "env": {
            "value": ""
        },
        "resourceLocation": {
            "value": "[resourceGroup().location]"
        },
        "databaseType": {
            "value": "serverless"
        },
        "capacity": {
            "value": 2
        },
        "databaseName": {
            "value": ""
        },
        "dbAdType": {
            "value": "User"
        },
        "dbAdLoginName": {
            "value": ""
        },
        "dbAdId": {
            "value": ""
        },
        "connectToVnet": {
            "value": true
        },
        "tags": {
            "value": {}
        }
    }
}
```
