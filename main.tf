data "aws_ssm_parameter" "ubuntu-focal" {
  name = "/aws/service/canonical/ubuntu/server/${var.ubuntu_version}/stable/current/amd64/hvm/ebs-gp2/ami-id"
}

resource "aws_eip" "this" {
  instance = aws_instance.bastion.id
  vpc      = true
  tags = var.tags
}

resource "aws_security_group" "this" {
  name        = "${var.bastion_name}"
  description = "Security group for bastion"

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group_rule" "this" {
  for_each          = toset(var.ingress_cidrs)

  cidr_blocks       = [each.key]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.bastion.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_instance" "this" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.bastion_instance_type

  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = concat(var.security_group_ids, [var.aws aws_security_group.this.id])

  monitoring = true

  tags = var.tags

  user_data = <<SCRIPT
#!/bin/bash

# Keys
touch /home/ubuntu/.ssh/authorized_keys
%{for ssh_key in var.ssh_keys~}
echo "${ssh_key}" >> /home/ubuntu/.ssh/authorized_keys
%{endfor~}
chown ubuntu: /home/ubuntu/.ssh/authorized_keys
chmod 0600 /home/ubuntu/.ssh/authorized_keys

${var.userdata}

echo 'echo "Ciphers aes128-ctr,aes192-ctr,aes256-ctr" | tee -a /etc/ssh/sshd_config' | tee -a /etc/rc.local
echo 'echo "MACs hmac-sha1,hmac-sha2-256,hmac-sha2-512" | tee -a /etc/ssh/sshd_config' | tee -a /etc/rc.local
echo 'systemctl reload ssh.service' | tee -a /etc/rc.local
echo 'exit 0' | tee -a /etc/rc.local
chmod +x /etc/rc.local
SCRIPT

  root_block_device {
    encrypted   = true
    volume_size = var.volume_size
  }
}
