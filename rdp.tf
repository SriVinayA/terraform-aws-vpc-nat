# Option 1: Using local values with heredoc (Recommended)
locals {
  rdp_content = <<-RDP_CONTENT
    auto connect:i:1
    full address:s:${aws_eip.windows_eip.public_ip}
    username:s:Administrator
    audiomode:i:2
    audiocapturemode:i:1
  RDP_CONTENT
}

resource "local_file" "vinay_rdp_file" {
  content  = local.rdp_content
  filename = "Vinay_Win${formatdate("YYYYMMDDhhmmss", timestamp())}.rdp"

  depends_on = [aws_eip_association.windows_eip_assoc]
}

resource "null_resource" "rdp_execute" {
  triggers = {
    rdp_file = local_file.vinay_rdp_file.filename
  }

  provisioner "local-exec" {
    command     = "open ${local_file.vinay_rdp_file.filename}"
    working_dir = path.module
  }

  depends_on = [local_file.vinay_rdp_file]
}