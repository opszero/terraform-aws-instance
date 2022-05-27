# AWS Bastion

AWS Bastion with multiple SSH Key support.

## Usage

``` sh
ssh-keygen -t rsa
```

``` sh
module "bastion" {
  source = "github.com/opszero/terraform-aws-bastion"

  ssh_keys = [ "ssh-rsa ..." ]
}
```

## Connect

 - Use [MrMgr](https://github.com/opszero/terraform-aws-bastion) to setup IAM access to the Bastion
 - `pip3 install pip3 install ec2instanceconnectcli`
 - `mssh --profile awsprofile ubuntu@i-1234566`

## Deployment

```sh
terraform init
terraform plan
terraform apply -auto-approve
```

## Teardown

```sh
terraform destroy -auto-approve
```
