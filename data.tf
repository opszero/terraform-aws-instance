data "template_file" "ec2_connect" {
  count = var.ec2_connect_installed ? 1 : 0

  template = file("${path.module}/ec2_connect.sh")
}

data "template_cloudinit_config" "config" {
  gzip          = false
  base64_encode = false

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.keys.rendered
  }

  part {
    content_type = "text/x-shellscript"
    content      = data.template_file.ec2_connect[0].rendered
  }
}

data "aws_caller_identity" "current" {}
