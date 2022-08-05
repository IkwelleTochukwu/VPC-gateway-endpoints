module "security-group-vpc_s3" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "4.9.0"

  vpc_id      = aws_vpc.VPC_s3.id
  description = "sg for the vc-s3"
  name        = local.name
  tags        = local.tags
  ingress_with_cidr_blocks = [
    {
      description = "ingress ssh"
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = "0.0.0.0/0"
    },

  ]

  egress_with_cidr_blocks = [
    {
      description = "egress all"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
}

