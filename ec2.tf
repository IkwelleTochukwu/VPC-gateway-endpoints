module "ec2_instance-bastion-host" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.1"

  name                   = local.name
  ami                    = var.ami
  availability_zone      = "${local.region}a"
  iam_instance_profile   = aws_iam_instance_profile.ec2-role-instance_profile.name
  instance_type          = var.instance_type
  key_name               = "loginkey"
  subnet_id              = aws_subnet.pub-subnetVPC-s3.id
  tags                   = local.tags
  vpc_security_group_ids = ["${module.security-group-vpc_s3.security_group_id}"]
}


module "ec2_instance-priv" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "4.1.1"

  name                   = local.name
  ami                    = var.ami
  availability_zone      = "${local.region}b"
  instance_type          = var.instance_type
  key_name               = "loginkey"
  subnet_id              = aws_subnet.priv-subnetVPC-s3.id
  tags                   = local.tags
  vpc_security_group_ids = ["${module.security-group-vpc_s3.security_group_id}"]

}