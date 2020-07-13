## Create a config/byok.tfvars file

- Create a directory called config and a file called byok.tfvars, add your IBM Cloud API key using the following format:
```
ibmcloud_api_key = "<Your API KEY>"
```

## Create all resources in Gen 1
- Initialize the Terraform providers and modules. Run:
```sh
terraform init
```

- Execute terraform plan by specifying location of variable files, state and plan file:
```sh
terraform plan -var-file=gen1/byok.tfvars -var-file=config/byok.tfvars -state=gen1/byok.tfstate -out=gen1/byok.plan
```

- Apply terraform plan by specifying location of plan file:
```sh
terraform apply -state-out=gen1/byok.tfstate gen1/byok.plan
```

- Notice the errors generated during the create.

- Delete all resources
```
terraform destroy -var-file=gen1/byok.tfvars -var-file=config/byok.tfvars  -state=gen1/byok.tfstate
```

## Create all resources in Gen 2 WITH AN ACCOUNT allowed to use BYOK for Block Storage
- Initialize the Terraform providers and modules. Run:
```sh
terraform init
```

- Execute terraform plan by specifying location of variable files, state and plan file:
```sh
terraform plan -var-file=gen2/byok.tfvars -var-file=config/byok.tfvars -state=gen2/byok.tfstate -out=gen2/byok.plan
```

- Apply terraform plan by specifying location of plan file:
```sh
terraform apply -state-out=gen2/byok.tfstate gen2/byok.plan
```

- All resources are created with success,, however notice that the Block Storage volume is created as Provider managed encryption, the expectation is that it is Customer managed.

- Delete all resources
```
terraform destroy -var-file=gen2/byok.tfvars -var-file=config/byok.tfvars  -state=gen2/byok.tfstate
```
