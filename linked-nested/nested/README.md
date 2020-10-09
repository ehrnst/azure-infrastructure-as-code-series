# Nested ARM template

Starting where we left advanced-templating. We create multiple storage accounts within a resource group.  
With this nested approach, we deploy the resource group it self, and create a new deployment resource within the parent (resource group) deployment.  

With nested templates it is crucial to pay attention to references and the validation scope of the nested template. Using expression validation is set by changing `expressionEvaluationOptions` to inner or outer (default).  
This directly affect how you can reference variables, parameters and resources.

While the previous examples show how to use functions, parameters, etc. This template is aimed to show nesting. We have therefor stripped some of the complexity from our other examples

`New-AzDeployment -Location "norwayeast" -TemplateFile .\linked-nested\nested\azure.deploy.json -TemplateParameterFile 
.\linked-nested\nested\azure.deploy.parameters.json -Name "nestingTemplates"`
