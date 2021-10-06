# Deploy Azure Bicep with GitHub Actions

In this part we show how to deploy Azure bicep files using GH actions. At the `root` of the directory, you will find twi `.yaml` files functioning as workflows in GitHub. 
`pipeline.yaml` shows the bare minimum of what is needed for deploying a bicep file, while `pipelineValidate.yaml` incorporates Biceps linter spec in to the validation part of the pipeline. By using linter we can make sure all our bicep files follow the best authoring practices. The linter engine is the same validation being done inside VSCode, but can also be used in your pipeline, and this example show how.

## setup

In order for the pipelines to work you will need to [set up your Azure and GitHub environment with secrets](https://docs.microsoft.com/en-us/azure/azure-resource-manager/bicep/deploy-github-actions?WT.mc_id=AZ-MVP-5003437). These secrets are basic configuration like a service principal and your subscription id.

For this demo, you also need additional secrets to be used for deploying the SQL server. In you secrets add the following

`BICEPDEMO_DBLOGIN_ID` with the guid of the user account
`BICEPDEMO_DBLOGIN_NAME` the login name like `user@domain.com`

## linter
The linter specification is controlled by `bicepconfig.json`. You can put this file where ever you want, the validation is done against the 'closest' to your bicep modules.