resource "aws_eip" "this" {
  instance = aws_instance.this.id
  vpc      = true
  tags     = var.tags
}

resource "aws_security_group" "this" {
  name        = var.bastion_name
  description = "Security group for bastion"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = var.tags
}

resource "aws_security_group_rule" "this" {
  for_each = toset(var.ingress_cidrs)

  cidr_blocks       = [each.key]
  from_port         = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.this.id
  to_port           = 22
  type              = "ingress"
}

resource "aws_instance" "this" {
  ami           = var.ami_id
  instance_type = var.instance_type

  associate_public_ip_address = true
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = concat(var.security_group_ids, [aws_security_group.this.id])

  monitoring = true

  tags = merge(var.tags, {
    Name = var.bastion_name
  })
  user_data_replace_on_change = var.user_data_replace_on_change
  user_data                   = data.cloudinit_config.config.rendered

  root_block_device {
    encrypted   = true
    volume_size = var.volume_size
  }
}

resource "aws_cloudwatch_metric_alarm" "aws_bastion_cpu_threshold" {
  alarm_name                = "${var.bastion_name}-cpu-alarm"
  comparison_operator       = "GreaterThanOrEqualToThreshold"
  evaluation_periods        = "2"
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/EC2"
  period                    = "300"
  statistic                 = "Average"
  threshold                 = "80"
  alarm_description         = "This metric monitors ec2 cpu utilization"
  insufficient_data_actions = []

  dimensions = {
    InstanceId = aws_instance.this.id
  }
}
