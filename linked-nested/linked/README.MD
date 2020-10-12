# Linked ARM templates

With linked ARM templates we have one main template and one or multiple 'child' templates.  

This example target a subscription and deploy a reousce group.  
Within the subscription scoped deployment, we create a new deployment and references a linked template. In this case we are using the template [in the copy example](https://github.com/ehrnst/arm-templates/tree/master/advanced-templating/4.0-copy) from the 'Advanced templating' section.  

> All parameters needed for both deployments are specified in the 'main' template.

Linked ARM templates are especially good when you have complex scenarios making a single template hard to read. Many companies also rely on linked templates when multiple departments are responsible for creating their best practice templates. Where the rest of the organization can know they use the latest version created by the responsible department.  

Each individual linked template will be a deployment them self. Azure Resource Manager (ARM) will therefor need to have access to the template through the URI provided (publiclly available), or you can use storage accounts on Azure.
There are upcoming changes here, where [template specs (preview)](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/template-specs?WT.mc_id=AZ-MVP-5003437) should solve some of the complexity and "security" issues with storage accounts and public templates.

Read more about [Linked ARM templates on Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/linked-templates?WT.mc_id=AZ-MVP-5003437)

`New-AzDeployment -Name "linkedMainTemplate" -Location "norwayeast" -TemplateFile .\linked-nested\linked\azure.deploy.json -TemplateParameterFile .\linked-nested\linked\azure.deploy.parameters.json`
