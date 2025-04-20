# 🚀 OpenVPN on AWS EC2 using Terraform

![Terraform](https://img.shields.io/badge/Terraform-v1.0+-5C4EE5?logo=terraform)

This Terraform project sets up an **OpenVPN server** on an **AWS EC2 instance**. It handles the full setup process, including:

- Creating an EC2 instance
- Generating a new key pair
- Configuring security groups (SG) to allow VPN traffic
- Installing OpenVPN via [angristan/openvpn-install.sh](https://github.com/angristan/openvpn-install)
- Downloading the generated `client.ovpn` file for connecting to the VPN

---

## 📦 Prerequisites

- [Terraform](https://www.terraform.io/downloads) v1.0+
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- AWS credentials configured (`~/.aws/credentials` or environment variables)


---

## 🛠 How It Works

1. **Terraform** provisions the infrastructure:
   - An EC2 instance (Amazon Linux 2 or Ubuntu)
   - A security group allowing:
     - SSH (port 22)
     - OpenVPN (UDP port 1194)
   - A key pair for SSH access

2. **User data** script installs:
   - OpenVPN using `openvpn-install.sh`
   - Automatically generates a client profile (`client.ovpn`)

3. The `client.ovpn` file is downloaded locally via SCP or SSM.

---

## ⚠️ Security Warning: Key Pair Handling
🚨 Important: For security reasons, do not use pre-generated or static key pairs (openvpn / openvpn.pub) included in this repo or elsewhere.
Instead, generate your own SSH key pair and provide the private key path for SSH access.
### 🔐 Generate Your Own SSH Key Pair
If you haven't already, create a new SSH key pair:
```bash
ssh-keygen -t rsa -b 4096 -f ./openvpn
```
This will generate:
 - openvpn (private key)
 - openvpn.pub (public key)

## 🚀 Getting Started

### 1. Clone this Repository

```bash
git clone https://github.com/yogendra-kokamkar/openvpn-terraform-install-aws.git
cd openvpn-terraform-install-aws
```
### 2. Initialize Terraform

```bash
terraform init
```
### 3. Configure the variables
Edit `terraform.tfvars` file to set:
 - Key pair name
 - Instance AMI ID
 - Note: You can further customize configurations directly in the `.tf` files.
### 4. Apply the Terraform Plan
```bash
terraform apply
```
Confirm with `yes` when prompted.

## 🔐 Accessing the OpenVPN Client File
Once the OpenVPN installation is complete, the client.ovpn file will be available in the same folder

## 🖥 Connecting to OpenVPN
 - Download the [OpenVPN client](https://openvpn.net/client-connect-vpn-for-windows/) for your OS.
 - Import the client.ovpn file.
 - Connect and enjoy secure browsing.

## 🧹 Teardown
To destroy all resources created by Terraform:
```bash
terraform destroy
```
## 📝 Notes
 - Default OpenVPN port is 1194 (UDP).
 - Ensure your IP is whitelisted in the security group for SSH.
 - openvpn-install.sh is a community script. Review it before use: https://github.com/angristan/openvpn-install

## 📄 License
This project is [MIT licensed](./LICENSE). See LICENSE for details.

## 🙌 Acknowledgments
 - angristan/openvpn-install – for the OpenVPN installer script
 - Terraform and AWS for cloud magic 🌩

