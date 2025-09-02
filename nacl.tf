resource "aws_network_acl" "public_nacl" {
  vpc_id     = aws_vpc.vpc-01.id
  subnet_ids = [aws_subnet.public_subnet.id]

  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    cidr_block = var.all_ipv4_cidr
  }

  ingress {
    rule_no    = 200
    action     = "allow"
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    cidr_block = var.all_ipv4_cidr
  }

  ingress {
    rule_no    = 300
    action     = "allow"
    protocol   = "tcp"
    from_port  = 3389
    to_port    = 3389
    cidr_block = "${local.home_ip}/32"
  }

  # Allow return traffic for outbound connections
  ingress {
    rule_no    = 400
    action     = "allow"
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    cidr_block = var.all_ipv4_cidr
  }

  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    cidr_block = var.all_ipv4_cidr
  }

  egress {
    rule_no    = 200
    action     = "allow"
    protocol   = "tcp"
    from_port  = 443
    to_port    = 443
    cidr_block = var.all_ipv4_cidr
  }

  # Allow all outbound ephemeral ports for return traffic
  egress {
    rule_no    = 300
    action     = "allow"
    protocol   = "tcp"
    from_port  = 1024
    to_port    = 65535
    cidr_block = var.all_ipv4_cidr
  }

  tags = {
    Name = "Public NACL"
  }
}

resource "aws_network_acl" "private_nacl" {
  vpc_id     = aws_vpc.vpc-01.id
  subnet_ids = [aws_subnet.private_subnet.id]

  ingress {
    rule_no    = 100
    action     = "allow"
    protocol   = "tcp"
    from_port  = 22
    to_port    = 22
    cidr_block = "${local.home_ip}/32"
  }

  egress {
    rule_no    = 100
    action     = "allow"
    protocol   = "tcp"
    from_port  = 80
    to_port    = 80
    cidr_block = var.all_ipv4_cidr
  }
}
