resource "aws_ec2_network_insights_path" "home_to_ec2" {
  source      = aws_internet_gateway.igw.id # traffic enters AWS via IGW
  destination = aws_instance.windows.id     # your EC2 instance
  protocol    = "tcp"

  filter_at_source {
    source_address = local.home_ip # your home public IP
    destination_port_range {
      from_port = 80
      to_port   = 80
    }
  }

  tags = {
    Name = "HomeToEC2-${random_pet.vinay_pet.id}"
  }
}

resource "aws_ec2_network_insights_analysis" "home_to_ec2" {
  network_insights_path_id = aws_ec2_network_insights_path.home_to_ec2.id
  wait_for_completion      = true
}
