# Azure template

## Parameters

Parameter name | Required | Description
-------------- | -------- | -----------
env            | Yes      |

### env

![Parameter Setting](https://img.shields.io/badge/parameter-required-orange?style=flat-square)



- Allowed values: `test`, `prod`

## Outputs

Name | Type | Description
---- | ---- | -----------
subnets | object |

## Snippets

### Parameter file

```json
{
    "$schema": "https://schema.management.azure.com/schemas/2015-01-01/deploymentParameters.json#",
    "contentVersion": "1.0.0.0",
    "metadata": {
        "template": "Bicep/3.modules/existing-vnet.json"
    },
    "parameters": {
        "env": {
            "value": ""
        }
    }
}
```
