# Using Bicep modules

In this demo we use modules to create more portable code. Modules also help us split complexity in to different files keeping the `main` files tidyer, but also the module files it self.
In this case, our `main.bicp` is set to deploy at the `subscription` level using `deploymentScope`. We can therfore deploy both resource groups and individiual resources.

Further the `main` file calls a SQL module. This module is responsible for creating a SQL server and a database.
Using the techniques we learned in our earlier demos we can configure the SQL server based on what is inputted. Things like server type `generalPurpose`, or `hyperScale`, auditing, and Azure defender is handled based on input. We also configure backup for the SQL Databases.
For audit and defender, we create a dedicated storage account and assign the SQL servers managed identity access to the storage accont. Since this is dedicated to the SQL server, and its sole purpose is to hold these logs, we hard code this in to the SQL module.

## Existing resources
Further, based on input, the SQL server is connected to a vnet/subnet.
The example try to show the the vnet/subnet does not follow the same lifecycle as the SQL server. Nor is it deployed with the same `main.json` file. The vnet and subnet already exsist, but since potentially many resources want to connect to it, we split this in to a separate module.
Modules does not need to deploy anything, it can simply reference existing resources like we do in `existing-vnet.bicep`. Based on input from the sql module, `sql.bicep` we can connect the existing vnets to our SQL server.

*The SQL module use all capabilities of Bicep shown in the other demos*
