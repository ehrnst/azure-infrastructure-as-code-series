# CI-CD

Templates used in a ci-cd
For this demo we have created a pipeline to use with Azure DevOps. This pipeline is conneced to the GitHub repo and wil trigger a build and release for every new commit to master branch.  
Demo uses one of the existing templates, but have its own parameter file.

We have set up the pipeline with three stages. Build, test, and release. This is considered best practice, but complexity varies from environment to environment.
