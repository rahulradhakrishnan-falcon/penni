# Pre-Requisites :

* S3 bucket for backend [ update in backend.tf #bucket ]
* DynamoDB table for lock [ update in backend.tf #dynamodb_table ]
* AWS profile creation
* Terraform version >= 1.0.11

## Terraform command to deploy :

First install all providers and plugins for the terraform project.

```shell
terraform init
```

Next run plan and see what infrastructure has changed and what will be added.

```shell
terraform plan
```

Finally apply the changes once confirmed.

```shell
terraform apply
```

# Architecture:

![alt text](https://github.com/rahulradhakrishnan-falcon/penni/blob/master/arch.png)





