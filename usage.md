# AWS Bastion

AWS Bastion with multiple SSH Key support.

## Usage

``` sh
ssh-keygen -t rsa
```

``` sh
module "bastion" {
  source = "github.com/opszero/terraform-aws-bastion"

  ssh_keys = [
     "ssh-rsa ..."
  ]
}
```
