# Nested ARM template

Starting where we left advanced-templating. We create multiple storage accounts within a resource group.  

- This example show how we can create resources with multiple scopes within the same template.  
- The main template is targeted at the subscription and deploy a resource group.  
Our nested template is dependent on the resource group and deploy our storage accounts to the newly created resource group.

> With nested templates it is crucial to pay attention to references and the validation scope of the nested template. Using expression validation is set by changing `expressionEvaluationOptions` to inner or outer (default).  
This directly affect how you can reference variables, parameters and resources.

[Learn more about nested ARM templates on Microsoft Docs](https://docs.microsoft.com/en-us/azure/azure-resource-manager/templates/linked-templates?WT.mc_id=AZ-MVP-5003437)

While the previous examples show how to use functions, parameters, etc. This template is aimed to show nesting. We have therefor stripped some of the complexity from our other examples

`New-AzDeployment -Location "norwayeast" -TemplateFile .\linked-nested\nested\azure.deploy.json -TemplateParameterFile 
.\linked-nested\nested\azure.deploy.parameters.json -Name "nestingTemplates"`
