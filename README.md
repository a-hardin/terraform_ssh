# Terraform Infrastructure As Code

This is an example of infrastructure as code using terraform

## Requirements

Terraform CLI download it [Here](https://www.terraform.io/downloads.html)

AWS CLI install it [Here](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)

AWS CLI Profile configure it [Here](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html)


## Installation

Change the environment variables in the file secret.auto.tfvars

Use terraform to initialize the project.

```bash
terraform init
```

Apply changes and spin up an AWS instance

```bash
terraform apply
```
When prompted review the action Terraform will perform, then type:
```bash
yes
```

Once completed a file named ssh_info.txt will be created. Inside this file will have the ssh terminal command needed to ssh into the AWS EC2 instance.

## Usage

Copy the first line of the file and execute it inside of a terminal. 
Example:
```bash
ssh ubuntu@<public ip address>
```
When prompted about the ECDSA key fingerprint type:
```bash
yes
```

You will now be inside the AWS EC2 instance.

## Errors

In secret.auto.tfvars make sure the aws region and ami id are compatible.

In secret.auto.tfvars make sure that your ssh public and private keys have the correct path.


## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License
[MIT](https://choosealicense.com/licenses/mit/)