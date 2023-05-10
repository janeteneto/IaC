# IaC

![image](https://user-images.githubusercontent.com/129942042/236436302-1d62c100-0029-4826-a092-01d8e13681f2.png)

- **Infrastructure as Code** is a software engineering **approach** that involves managing and provisioning computing infrastructure (e.g. servers, networks, databases, etc.) using code and automation instead of manual configuration.
- This approach treats infrastructure as software and uses version control, testing, and other software engineering practices to manage it.
- Used in DevOps environments to automate the deployment of applications and infrastructure changes and to ensure that infrastructure is consistent, scalable, and secure.

- **Benefits** include automation, consistency, scalability, security and collaboration. Popular IaC tools such as **Terraform, Ansible, Puppet, and Chef** are used extensively in the industry to implement these benefits.

![image](https://user-images.githubusercontent.com/129942042/236436759-6767c113-fcd1-460e-a056-4461ce9e59da.png)

- It is being used in a variety of industries, such as tech, health and government. Examples of companies include Netflix.

## Configuration Management

- Process of identifying, organising, and controlling configuration items (CIs) within a system or IT infrastructure.
- A configuration item is any component of an IT system that needs to be managed and tracked throughout its lifecycle, such as hardware devices, software applications, and configuration files.
- The goal of configuration management involves establishing a baseline configuration for each system, tracking changes to the configuration over time, and managing the relationships between different configuration items.

- Its main activities include:
1. Configuration identification: Identifying and documenting the CIs within an IT system.

2. Configuration control: Controlling changes to the configuration of CIs, including tracking changes, assessing their impact, and approving or rejecting changes.

3. Configuration status accounting: Recording and reporting the status of CIs and their associated attributes, including their current configuration, version, and location.

4. Configuration audit: Verifying the configuration of CIs against the baseline configuration, identifying any discrepancies, and taking corrective action.

![image](https://user-images.githubusercontent.com/129942042/236437006-a2c19134-cc7a-428a-a89c-6e30f5f90bc6.png)

## Ansible

- It is as IaC open-source configuration management and automation tool.
- Uses a simple, human-readable syntax called **YAML** to define tasks and playbooks, which are sequences of tasks that can be executed in order.
- **Built in Python**

With this possible it is possible to automate tasks such as:

- Server provisioning and configuration management
- Application deployment and configuration
- Network automation and configuration
- Security hardening and compliance
- Continuous delivery and release management

- It uses **clientless/agentless architecture**, which means it does not require any software to be installed on the target systems, it uses **SSH** instead

![image](https://user-images.githubusercontent.com/129942042/236437344-27ed4426-d426-4a2e-b450-d5ed596e6a72.png)

- Its **benefits** include ease of use, agentles/clientless architecture, good for production enviroment as it can be run multiple times without side effects, scalable and can be intregated with other tools like Jenkins, Kubernetes, and AWS which are tools we focus on in this course.

## YAML

![image](https://user-images.githubusercontent.com/129942042/236437584-cb191f4b-1f9a-4abd-84a7-2e794a485836.png)

- Human-readable data serialisation **language** that is used to define data structures such as lists, maps, and key-value pairs.
- Used to define the desired state of infrastructure resources, such as servers, applications, and network devices. Ansible uses YAML syntax to create **playbooks**, which are scripts that define a set of tasks that should be executed on a set of hosts.
- Used by Docker and Kuberneties.

**Playbooks** - In Ansible, playboos are YAML files that describe the configuration and deployment of infrastructure resources. Playbooks contain a set of tasks, each of which performs a specific action on the target host(s), such as installing software packages, configuring settings, and starting or stopping services.

# Ansible Controller Setup

- The new script on the vagrant file is to run 3 virtual machines in vagrant
- Script is in Ansible controller (yaml file)
- We dont need ansible on the nodes only the controller

**Dependencies:**
- Python betwwen 2.7 and 3.6
- Ubuntu 18.04 (bcus it has git and python by default)
(we don't need to install these anywhere)

## Steps:

![image](https://github.com/janeteneto/IaC/assets/129942042/d784173d-53df-4536-90f4-688c997791d5)

1. Do vagrant up for the 3 VM's

2. Do `sudo apt update && upgrade -y` for the 3 VM's

4. Script for ansible controller setup - On the controller terminal run:

`sudo apt install software-properties-common`
`sudo apt-add-repository ppa:ansible/ansible`
`sudo apt-get update`
`sudo apt-get install ansible`

5. To change into the `web` VM, run `ssh vagrant@192.168.56.10`

6. Password is: vagrant
(you won't see the letters when you type)

7. To exit, type `exit`

8. Back on the controller vm, run `cd /etc/ansible/`


9. Run `sudo nano ansible.cfg` to open this file in the nano editor and the following line of code:
````
host_key_checking = false
````
- this is to make the next step work

10. Run `sudo nano hosts` - to open hosts file and add this:

````
[web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant
````
11. Run `sudo ansible web -m ping` - to send the ping request to all the server nodes in the ansible file


### How to copy a file from controller to the web server

1. Create a file with an approrpiate name and open it with nano editor to add a line

2. On the controller vm run the following command:

````
sudo ansible web -m copy -a "src=/etc/ansible/testing.txt dest=/home/vagrant"
````

- `src` - is where you put the path to the file you want to copy
- `dest` - is where you put the path to where you want to paste the file. In this case I wanted to paste `testing.txt` in the web's home location.

### How to create a playbook to install nginx in the `web` server

- Have in mind that a yaml file starts with `----`

1. Run `sudo nano install-nginx-playbook.yml`

2. Add this script:

````
---
- hosts: web
  gather_facts: yes
  become: true
  tasks:
  - name: Install nginx in web-server
    apt: pkg=nginx state=present
````

- This means:

`- hosts: web` - where would you like to install nginx

`gather_facts: yes` - would you like to see logs

`become: true` - do we need admin access - sudo
 ````
 tasks:
  - name: Install nginx in web-server
  ````
  - instructions
   
 `apt: pkg=nginx state=present` - ensures nginx status is active

3. Run `sudo ansible-playbook install-nginx-playbook.yml` - to use the playbook

4. Do `sudo ansible web -a "systemctl status nginx"` - to check the status of nginx in the web vm

### How to create a playbook to install nodejs in the `web` server and start the app

1. Create a yml file with the command `sudo nano install-nodejs-playbook.yml`

2. Add the following script:
````
---
- hosts: web
  gather_facts: yes
  become: true
  tasks:
  - name: Install nodejs in web server
    apt: pkg=nodejs state=present
  - name: Install npm in web server
    apt: pkg=npm state=present
  - name: Install python in web server
````

3. As the other playbook, run `sudo ansible-playbook install-nodejs-playbook.yml` - to use the playbook

4. Move app folder to the web VM with the command:
````
scp -r /c/Users/user/tech221_virtualisation/app vagrant@192.168.33.10:/home/vagrant
````
- change the path to app folder to your own

5. Ssh into web vm and cd into app

6. Run `node app.js`

-App should be running on it's ip on port 3000

### Setup of MongoDB in the db agent node

1. Cd into `/etc/ansible/`

2. Run `sudo nano mongo-db-playbook.yml` to create this new file

3.  Add this script to the file:

````
---
- hosts: db
  gather_facts: yes
  become: true
    tasks:
  - name: Configuring Mongodb in db agent node
    apt: pkg=mongodb state=present
````

4. Run `sudo nano ansible-playbook mongo-db-playbook.yml` to run the script

5. Do a status check of Mongodb with the command `ansible db -a "sudo systemctl status mongodb"`. This will only work before you ssh into db and have the hosts and yml file set correctly. 

### DB condifguration

1. Make sure you to ssh into the db through the controller

2. Cd into `/etc`

3. Run `sudo nano mongodb.conf` to get inside the file

4. Change bind ip to 0.0.0.0 for port 2701

5. Run `sudo systemctl restart mongodb` and `sudo systemctl enable mongodb`

6. Ssh into web ip

7. Run `export DB_HOST=mongodb://192.168.33.11:27017/posts`

8. Cd into app folder

9. Run `npm install` then `npm start`

### Playbook to change bindIp on mongodb conf

1. Make sure to be in the controller on the `/etc/ansible`

2. Run `sudo nano mongo-conf.yml` and add the following script:

````
---
- hosts: db
  gather_facts: yes
  become: true
  tasks:
    - name: Change bindip
      lineinfile:
        path: /etc/mongodb.conf
        regexp: 'bind_ip = 0.0.0.0'
        line: 'bind_ip = 0.0.0.0'
        backrefs: yes
    - name: restart mongodb
      shell: systemctl restart mongodb
    - name: enable mongodb
      shell: systemctl enable mongodb
````

**Some useful commands are:**

- `sudo apt install tree` - see list (`ls`) but in a tree format

- `sudo ansible all -m ping` - looks for agent nodes in the cfn file, if it finds them, it will send a request to ping the server nodes

- `sudo ansible web -a "date"` - to check date

- `sudo ansible all -a "date"` - to check date in all the servers

- `sudo ansible all -a "uname -a"` - to check who is the user in all servers

- `sudo ansible all -a "free"` - will tell you the free memory available for all the servers
