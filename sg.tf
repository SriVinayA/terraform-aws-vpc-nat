resource "aws_security_group" "Windows_SG_tf" {
  name        = "${random_pet.vinay_pet.id}_WindowSG"
  description = "Allow RDP, HTTP, and HTTPS inbound traffic"
  vpc_id      = aws_vpc.vpc-01.id

  ingress {
    description = "allows inbound RDP 3389"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = [ "${local.home_ip}/32" ]
  }

  ingress {
    description = "allows inbound HTTP 80"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.all_ipv4_cidr]
  }

  ingress {
    description = "allows inbound HTTPS 443"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [var.all_ipv4_cidr]
  }

  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ipv4_cidr]
  }

  tags = {
    Name = "WindowSG-${random_pet.vinay_pet.id}"
  }
}


resource "aws_security_group" "Linux_SG_tf" {
  name        = "${random_pet.vinay_pet.id}_LinuxSG"
  description = "Allow SSH, and MySQL"
  vpc_id      = aws_vpc.vpc-01.id

  ingress {
    description = "allows inbound SSH 22"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ "${aws_instance.windows.private_ip}/32" ]
  }

  ingress {
    description = "allows inbound MySQL 3306"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = [ "${aws_instance.windows.private_ip}/32" ]
  }

  egress {
    description = "allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.all_ipv4_cidr]
  }

  tags = {
    Name = "${random_pet.vinay_pet.id}-LinuxSG"
  }
}
