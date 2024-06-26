resource "aws_security_group" "remote_access" {
  name_prefix = "${local.name}-remote-access"
  description = "Allow remote SSH access"
  vpc_id      = module.vpc.vpc_id

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/8"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  lifecycle {

    precondition {
      condition     = module.vpc.vpc_owner_id == data.aws_caller_identity.current.account_id
      error_message = "Target account should match the owner id"
    }

    precondition {
      condition     = module.vpc.vpc_enable_dns_support == true
      error_message = "DNS support should be enabled"
    }

  }

  tags = merge(local.tags, { Name = "${local.name}-remote" })
}