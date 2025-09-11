# HashiCorp Certified Terraform: Associate Notes

EC2 : elastic computer aws


## terraform init
_verfify_

    terraform plan

_deploy_

    terraform apply

_autoapprove_
    terraform apply -auto-approve

## terraform refresh(not recommended, terraform plan do it automatically, deprecated)

## removed all
    terraform plan -destroy

    terraform apply -destroy

## removed specific resource
    terraform destroy -target (resource type+localresourcename)


## update the depency without the necesity of remove the terraform.lock.hcl file
    terraform init -upgrade

## Default location of provider block
### MAC or Linux
    $HOME/.aws/config
    $HOME/.aws/credentials

### Windows
    %USERPROFILE%\.aws\config
    %USERPROFILE%\.aws\credentials

# Providers
## namespaces
1. Official, hashicorp
2. Partner, mongodb/mongodbatlas
3. Community, diff name like partner

## structure directory terraform
    main terraform / variables.tf / <env>.tfvars

## Selection tfvars by env(if not named terraform.tfvars) also -var="instance=value"
## Environment variable TF_VAR_*
    terraform plan -var-file="prod.tfvars"


## Variables definition precedence
 > later sources taking precedence over earlier ones(env variables/terraform.tfvars/terraform.tfvars.json/*.auto.tfvars or *.tfvars.json/-var -var-file options)


## Inside resource
> ${count.index}

## Conditional
> == ? true : false (==, !=, && , || , "")

## ${path.module} // current directory

## TF_LOG (info,trace)
> export TF_LOG = INFO
> export TF_LOG_PATH = terraform.tx
>
## Errors can occur in 4 stages: Language, State, Core and Provider Errors(Authentication API Calls)

## Metaarguments(depends_on,count,for_each,lifecycle,provider)
>> lifecycle (create_before_detroy, prevent_destroy, ignore_changes, replace_triggered_by)
``
  lifecycle {
    ignore_changes = [tags] | all
    create_before_destroy = true
    prevent_destroy = true
  }
``

## count when resources are identical,a use for_each when different

## list items are indexed and can have duplicated values
## Set can only store unique elements. set(string)

## Object a proper structure is generally required, if added more values they will be discard
``
variable "object"{
    type = object({Name = string, userId = number})
}
``