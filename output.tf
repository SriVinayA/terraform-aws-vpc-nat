output "nat_public_ip" {
  value = aws_eip.nat_eip.public_ip
}

output "random_pet" {
  value = random_pet.vinay_pet.id
}

output "random_id" {
  value = {
    b64_std     = random_id.vinay_id.b64_std
    b64_url     = random_id.vinay_id.b64_url
    dec         = random_id.vinay_id.dec
    byte_length = random_id.vinay_id.byte_length
    id          = random_id.vinay_id.id
  }
}

output "windows_details" {
  value = {
    id            = aws_instance.windows.id
    public_ip     = aws_instance.windows.public_ip
    private_ip    = aws_instance.windows.private_ip
    subnet_id     = aws_instance.windows.subnet_id
  }
}

output "linux_details" {
  value = {
    id            = aws_instance.Linux_tf.id
    public_ip     = aws_instance.Linux_tf.public_ip
    private_ip    = aws_instance.Linux_tf.private_ip
    subnet_id     = aws_instance.Linux_tf.subnet_id
  }
}

output "nat_details" {
  value = {
    id                   = aws_nat_gateway.nat_gw.id
    allocation_id        = aws_nat_gateway.nat_gw.allocation_id
    subnet_id           = aws_nat_gateway.nat_gw.subnet_id
    network_interface_id = aws_nat_gateway.nat_gw.network_interface_id
    private_ip          = aws_nat_gateway.nat_gw.private_ip
    public_ip           = aws_nat_gateway.nat_gw.public_ip
  }
}

output "home_ip" {
  value = local.home_ip
}

output "vinay_web_server_encrypted_pwd" {
  value = aws_instance.windows.get_password_data
  sensitive = false  
}
resource "local_file" "vinay_encrpt_pwd" {
  filename = "vinay_windows_encrypted_password.txt"
  content = aws_instance.windows.password_data

  provisioner "local-exec" {
    command = "echo ${local_file.vinay_encrpt_pwd.content}| base64 -d | openssl pkeyutl -decrypt -inkey ./${local_file.vinay_key_pair_private.filename} -out vinay_decrypt_password.txt"
  }
}

output "network_insights_analysis_details" {
  value = {
    id                  = aws_ec2_network_insights_analysis.home_to_ec2.id
    arn                 = aws_ec2_network_insights_analysis.home_to_ec2.arn
    status              = aws_ec2_network_insights_analysis.home_to_ec2.status
    status_message      = aws_ec2_network_insights_analysis.home_to_ec2.status_message
    path_found          = aws_ec2_network_insights_analysis.home_to_ec2.path_found
    alternate_path_hints = aws_ec2_network_insights_analysis.home_to_ec2.alternate_path_hints
    warning_message     = aws_ec2_network_insights_analysis.home_to_ec2.warning_message
  }
}


output "network_insights_path_info" {
  description = "Details of the Network Insights Path from home to EC2"
  value = {
    path_id        = aws_ec2_network_insights_path.home_to_ec2.id
    source         = aws_ec2_network_insights_path.home_to_ec2.source
    destination    = aws_ec2_network_insights_path.home_to_ec2.destination
    protocol       = aws_ec2_network_insights_path.home_to_ec2.protocol
    destination_port = aws_ec2_network_insights_path.home_to_ec2.destination_port
    tags           = aws_ec2_network_insights_path.home_to_ec2.tags
  }
}