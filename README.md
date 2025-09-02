# AWS VPC with NAT Gateway - Terraform Infrastructure

This Terraform project creates a complete AWS VPC infrastructure with NAT Gateway, including Windows and Linux EC2 instances in a secure network setup.

## 🏗️ Architecture Overview

The infrastructure consists of:

- **VPC** with DNS support (172.16.0.0/20)
- **Public Subnet** (172.16.0.0/21) in us-east-2a
- **Private Subnet** (172.16.8.0/21) in us-east-2b
- **Internet Gateway** for public internet access
- **NAT Gateway** for private subnet outbound internet access
- **Windows Instance** (t3.micro) in public subnet with Elastic IP
- **Linux Instance** (t3.micro) in private subnet
- **Security Groups** and **Network ACLs** for layered security

## 📋 Prerequisites

- [Terraform](https://www.terraform.io/downloads.html) >= 1.12.0
- [AWS CLI](https://aws.amazon.com/cli/) configured with appropriate credentials
- AWS account with necessary permissions to create VPC, EC2, and related resources

## 🚀 Quick Start

1. **Clone the repository**

   ```bash
   git clone <repository-url>
   cd "VPC with NAT"
   ```

2. **Initialize Terraform**

   ```bash
   terraform init
   ```

3. **Review the plan**

   ```bash
   terraform plan
   ```

4. **Apply the configuration**

   ```bash
   terraform apply
   ```

5. **Access your instances**
   - Windows: Use the generated RDP file or connect via RDP to the Elastic IP
   - Linux: SSH through the Windows instance (bastion host pattern)

## 📁 File Structure

```
├── data.tf              # Data sources (external IP detection)
├── eip.tf               # Elastic IP configurations
├── gateways.tf          # Internet and NAT gateways
├── keys.tf              # SSH key pair generation
├── linux.tf             # Linux EC2 instance
├── nacl.tf              # Network Access Control Lists
├── network_insights.tf  # AWS Network Insights for connectivity analysis
├── output.tf            # Output values and password decryption
├── providers.tf         # Terraform and AWS provider configuration
├── random.tf            # Random resources for unique naming
├── rdp.tf               # RDP file generation for Windows access
├── rt.tf                # Route tables configuration
├── sg.tf                # Security groups
├── variables.tf         # Input variables
├── vpc.tf               # VPC and subnet configuration
├── windows.tf           # Windows EC2 instance
└── .gitignore           # Git ignore rules for sensitive files
```

## 🔧 Configuration

### Variables

Key variables that can be customized in `variables.tf`:

| Variable                | Default               | Description         |
| ----------------------- | --------------------- | ------------------- |
| `vpc_cidr`              | 172.16.0.0/20         | VPC CIDR block      |
| `public_cidr`           | 172.16.0.0/21         | Public subnet CIDR  |
| `private_cidr`          | 172.16.8.0/21         | Private subnet CIDR |
| `windows_ami`           | ami-05b00365623a86bd3 | Windows Server AMI  |
| `linux_ami`             | ami-0bb7d855677353076 | Linux AMI           |
| `instance_type_t3micro` | t3.micro              | EC2 instance type   |

### Region Configuration

The project is configured for `us-east-2` region by default. Update `providers.tf` to change the region.

## 🔒 Security Features

- **Dynamic IP Detection**: Automatically detects your public IP for restrictive access rules
- **Bastion Host Pattern**: Windows instance in public subnet, Linux in private subnet
- **Layered Security**: Both Security Groups and Network ACLs
- **Encrypted Windows Password**: Automatic generation and decryption
- **SSH Key Management**: Automatically generated key pairs

### Security Groups

- **Windows SG**: Allows RDP (3389), HTTP (80), HTTPS (443)
- **Linux SG**: Allows SSH (22) and MySQL (3306) only from Windows instance

## 📊 Outputs

After deployment, the following information will be available:

- NAT Gateway public IP
- Instance details (IDs, IPs, subnet IDs)
- Windows password (automatically decrypted)
- Network insights analysis results
- Generated random identifiers

## 🔑 Access Instructions

### Windows Instance

1. Use the auto-generated RDP file: `Vinay_Win[timestamp].rdp`
2. Or manually connect to the Elastic IP using RDP
3. Username: `Administrator`
4. Password: Check `vinay_decrypt_password.txt`

### Linux Instance

1. SSH to Windows instance first (bastion host)
2. From Windows, SSH to Linux instance using the private IP
3. Use the generated private key file

## 🧹 Cleanup

To destroy all resources:

```bash
terraform destroy
```

**⚠️ Warning**: This will permanently delete all created resources.

## 📝 Generated Files

The following files are automatically generated (excluded from Git):

- `*.pem` - SSH private/public key files
- `*.rdp` - RDP connection files
- `*password*.txt` - Decrypted Windows passwords
- `*.tfstate*` - Terraform state files

## 🔍 Network Insights

The project includes AWS Network Insights Path analysis to validate connectivity from your home IP to the EC2 instances. Results are available in the Terraform outputs.

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## ⚠️ Important Notes

- **Costs**: This infrastructure will incur AWS charges (NAT Gateway, EC2 instances, Elastic IPs)
- **Security**: Review and adjust security group rules based on your requirements
- **AMI IDs**: Update AMI IDs in variables.tf for your preferred operating systems
- **State Management**: Consider using remote state storage for production deployments

## 🆘 Troubleshooting

### Common Issues

1. **AMI Not Available**: Update AMI IDs in `variables.tf` if the default AMIs are not available in your region
2. **Permission Denied**: Ensure your AWS credentials have sufficient permissions
3. **Resource Limits**: Check AWS service limits if resource creation fails
4. **Network Issues**: Verify your home IP is correctly detected in outputs

### Support

For issues and questions:

1. Check the Terraform logs: `terraform apply -debug`
2. Review AWS CloudTrail for API call details
3. Validate your AWS credentials and permissions

---

**Built with ❤️ using Terraform and AWS**
