# Terraform script to create a service on the cloud
# set up cloud provider with Terraform
# who is the provider - AWS
# how to codify Terraform - syntax - name of resource/task{key = value }
# terraform init, the terraform plan, then terraform apply", then "terraform destroy"

provider "aws" {
	 region = "eu-west-1"
}

# create a service on AWS (ec2 instance)
resource "aws_instance" "app_instance" {
	ami = var.ami_id
	# ami = ami-06042513c73c0c668
	instance_type = "t2.micro"
	associate_public_ip_address = true
	tags = {
	  Name = "janete_terraform"
	}
}
