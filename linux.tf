resource "aws_instance" "Linux_tf" {
    subnet_id = aws_subnet.private_subnet.id
    ami = var.linux_ami
    instance_type = var.instance_type_t3micro
    key_name = aws_key_pair.vinay_key_pair.key_name
    vpc_security_group_ids = [ aws_security_group.Linux_SG_tf.id ]

    ebs_block_device {
        device_name = "/dev/xvda"
        volume_size = 30
        volume_type = "gp2"
        delete_on_termination = true
    }

    tags = {
        Name = "${random_id.vinay_id.id}_linux"
    }
}