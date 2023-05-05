# IaC

![image](https://user-images.githubusercontent.com/129942042/236436302-1d62c100-0029-4826-a092-01d8e13681f2.png)

- **Infrastructure as Code** is a software engineering **approach** that involves managing and provisioning computing infrastructure (e.g. servers, networks, databases, etc.) using code and automation instead of manual configuration.
- This approach treats infrastructure as software and uses version control, testing, and other software engineering practices to manage it.
- Used in DevOps environments to automate the deployment of applications and infrastructure changes, and to ensure that infrastructure is consistent, scalable, and secure.

- **Benefits** include, automation, consistency, scalability, security and collaboration. Popular IaC tools such as **Terraform, Ansible, Puppet, and Chef** are used extensively in the industry to implement these benefits.

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

## Ansible

- It is as IaC open-source configuration management and automation tool.
- Uses a simple, human-readable syntax called **YAML** to define tasks and playbooks, which are sequences of tasks that can be executed in order.

With this possible it is possible to automate tasks such as:

- Server provisioning and configuration management
- Application deployment and configuration
- Network automation and configuration
- Security hardening and compliance
- Continuous delivery and release management

- It uses **clientless architecture**, which means it does not require any software to be installed on the target systems, it uses **SSH** instead

- Its **benefits** include ease of use, agentles/clientless architecture, good for production enviroment as it can be run multiple times without side effects, scalable and can be intregated with other tools like Jenkins, Kubernetes, and AWS which are tools we focus on in this course.

## YAML

- Human-readable data serialisation **language** that is used to define data structures such as lists, maps, and key-value pairs.
- Used to define the desired state of infrastructure resources, such as servers, applications, and network devices. Ansible uses YAML syntax to create **playbooks**, which are scripts that define a set of tasks that should be executed on a set of hosts.

**Playbooks** - In Ansible, playboos are YAML files that describe the configuration and deployment of infrastructure resources. Playbooks contain a set of tasks, each of which performs a specific action on the target host(s), such as installing software packages, configuring settings, and starting or stopping services.