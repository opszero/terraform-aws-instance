data "cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content = templatefile("${path.module}/keys.tftpl", {
      userdata = var.user_data,
      ssh_keys = var.ssh_keys
    })
  }

  part {
    content_type = "text/x-shellscript"
    content      = file("${path.module}/ec2_connect.sh")
  }
}
