
![image](https://github.com/janeteneto/IaC/assets/129942042/5d473528-70e8-4df9-b774-a9bbe70db69f)

### Installing Terraform using Chocolatey

1. Open a Windows Powershell terminal as admin (run as admin)

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
          Name = "tech221_janete_terraform_app"
        }
}
````

9. Save and exit and run **`terraform plan`**

10. Run **`terraform apply`**

11. type yes

### Building a VPC network with Terraform

![2023-05-11 (6)](https://github.com/janeteneto/IaC/assets/129942042/49dd639b-3384-4734-a4b3-96d0ca191ac3)

#### Main.tf Configuration for VPC, subnet and instance

- **Let's launch a VPC,  public subnet, internet gateway, route table and ec2 instance using Terraform. This is how it should look like:**

![2023-05-12 (6)](https://github.com/janeteneto/IaC/assets/129942042/6b95bcbd-86d9-4fd9-8f60-f304924a111b)
 
 - On the image above, I first provided a region, then the first resource is for my vpc.
 - Then for internet gateway, I refered to the my vpc so that it is connected
 - On the security groups resources, I made sure to allow ports 22, 80 and 3000 from anywhere

![2023-05-12 (7)](https://github.com/janeteneto/IaC/assets/129942042/c5c3aef0-8cd6-4442-b87a-59ea1049c78d)

- On the image above, 
### Launch app on instance (manually)

1. Open a new terminal and cd into .ssh file

2. Run `scp -i "tech221.pem" -r /c/Users/user/tech221_virtualisation/app ubuntu@52.49.90.189:/home/ubuntu` - to copy app to instance, in which:

- `/c/Users/user/tech221_virtualisation/app` is the path to where your app folder is

- `52.49.90.189` is the puclic ip of your instance
