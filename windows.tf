resource "aws_instance" "windows" {
    subnet_id = aws_subnet.public_subnet.id
    ami = var.windows_ami
    instance_type = var.instance_type_t3micro
    get_password_data = true
    ebs_block_device {
      device_name = "/dev/sda1"
      volume_size = 30
      volume_type = "gp3"
    }
    vpc_security_group_ids = [ aws_security_group.Windows_SG_tf.id ]
    key_name = aws_key_pair.vinay_key_pair.key_name

    tags = {
        Name = "${random_id.vinay_id.id}_windows"
    }
}

resource "aws_eip_association" "windows_eip_assoc" {
    instance_id = aws_instance.windows.id
    allocation_id = aws_eip.windows_eip.id
}