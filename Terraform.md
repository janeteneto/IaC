### Installing Terraform using Chocolatey

1. Open a Windows Powershell terminal as admin (run as admin9

2. Paste the following code to automatically install Chocolatey:
````
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
````

3. Wait a few seconds until the installation is complete and then you can run the following command:
````
choco install terraform
````

4. Run `refreshenv` then check the installation with the command `terraform --version`

### Create env variable for AWS Keys (for Windows)

1. On Windows environment, open your menu and look for `Edit the system environment variables`

2. Press `Environment Variables` then on the `User variables` section, press `new`

3. Add the variable: Name: 'aws_access_key_id', Value: enter the access key

4. Add another variable: 'aws_secret_access_key', Value: enter the secret access key

###
1. Open a Git terminal as admin

2. Create a new directory with an appropriate name. I named it `terraform`, with the command `mkdir terraform`

3. Run `nano main.tf` - to create and edit a terraform file with instructions for the aws infrastructure

4. Add the following code:
````
provider "aws" {
         region = "eu-west-1"
}
````

5. Save and exit

6. Run **`terraform init`** - to initialize the insfrastructure, you should see on the terminal a message saying that it has bee

7. Open the same folder with command `nano main.tf`

8. Add the following code:
````
resource "aws_instance" "app_instance" {
        ami = "ami-id"
        instance_type = "t2.micro"
        associate_public_ip_address = true
        tags = {
          Name = "eng221_shahrukh_terraform_app"
        }
}
````

9. Save and exit and run **`terraform plan`**
