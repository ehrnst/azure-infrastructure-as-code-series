# Deployment scripts

deployment scripts within ARM templates allows you to perform last mile configuration on your deployments.  

`New-AzDeployment -Name "linked-script" -Location "norwayeast" -TemplateFile .\deployment-scripts\azure.deploy.json -TemplateParameterFile .\deployment-scripts\azure.deploy.parameters.json`
