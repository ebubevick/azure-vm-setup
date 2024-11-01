# # Azure Infrastructure Deployment for Public and Private VMs

This repository contains Terraform code to provision and manage infrastructure for an online banking platform on Azure.

## Overview

The Terraform scripts in this repo are used to create and maintain a highly secure and reliable cloud infrastructure. This infrastructure includes both public and private areas to separate customer-facing services from sensitive backend processes, allowing for thorough testing under load and outage conditions.

## Scenario

Your team is building an online banking platform, which needs to be both highly secure and reliable. To test the setup, you’re creating a basic infrastructure in Azure that includes both public and private areas for different parts of the application. The public part will handle customer traffic, while the private part will manage sensitive backend processes. Setting up this way lets you test how well the system holds up under load and during outages.

The application has two main components:

1. **Public-Facing Services**: These are customer-facing, requiring high availability and load balancing to handle user traffic securely. This component needs to be accessible from the internet.
2. **Internal Services**: These backend services handle transaction processing and database management. They require internet access for updates but need to be isolated from direct internet exposure for security.

## Solution Overview

1. **Network Setup**: Create a Virtual Network with separate public and private subnets across two or more Availability Zones for redundancy.
2. **Load-Balanced VMs**: Deploy virtual machines (VMs) in each subnet, with a load balancer for public VMs to manage customer traffic smoothly.
3. **NAT Gateway for Private VMs**: Allow private VMs to access the internet safely through a NAT Gateway for updates without exposing them directly.
4. **Secure Access**: Use Azure Bastion to connect securely to VMs, to test traffic handling.

## Additional Resources
For a visual guide on how to accomplish this using the Azure Portal, you can check out my blog post [here](https://medium.com/@omekwuvictor/building-a-secure-and-reliable-production-environment-on-azure-with-public-and-private-networks-3c2565f7973a) for a detailed, graphical experience.

## Prerequisites

- Terraform version 0.12 or later.
- Access to your Azure account with necessary permissions.

## Getting Started

1. **Clone the repository**:
    ```sh
    git clone https://github.com/ebubevick/azure-vm-setup.git
    ```

2. **Navigate to the directory**:
    ```sh
    cd your-repo
    ```

3. **Initialize Terraform**:
    ```sh
    terraform init
    ```

4. **Plan and apply the infrastructure**:
    ```sh
    terraform plan
    terraform apply
    ```

## Structure

```plaintext

├── bastion-host.tf
├── load-balancer-setup.tf
├── main-config.tf
├── nat-gateway-setup.tf
├── network-security-group.tf
├── virtual-network.tf
└── virtual-machines-setup.tf
