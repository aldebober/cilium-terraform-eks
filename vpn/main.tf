provider "aws" {
  region  = var.region
  profile = var.profile
}

locals {
  id = "test"

  project_tags = {
    "terrarom" = "true"
    "Name"     = "wirefuard-vpn-${terraform.workspace}"
    "Env"      = "${terraform.workspace}"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}


resource "aws_security_group" "vpn_sg" {
  description = "Wireguard VPN SG"
  name        = "vpn-sg-${terraform.workspace}"
  vpc_id      = data.terraform_remote_state.networking.outputs.vpc_id

  ingress {
    description = "wireguard"
    from_port   = 51820
    to_port     = 51820
    protocol    = "udp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Ssh from vpn"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["35.159.151.129/32"]
  }

  egress {
    description = "Egress to all"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.project_tags)
}

resource "aws_network_interface" "vpnw" {
  subnet_id         = data.terraform_remote_state.networking.outputs.public_subnets[0]
  security_groups   = [aws_security_group.vpn_sg.id]
  source_dest_check = false
  depends_on = [
    aws_security_group.vpn_sg,
  ]

  tags = merge(local.project_tags)
}

resource "aws_instance" "vpn_wireguard" {
  key_name                = "${local.id}-vpn-${terraform.workspace}"
  ami                     = data.aws_ami.ubuntu.id
  instance_type           = "t3a.micro"
  disable_api_termination = true
  user_data               = file("bootstrap.sh")
  ebs_optimized           = true
  monitoring              = true

  ebs_block_device {
    device_name           = "/dev/sda1"
    volume_size           = 30
    volume_type           = "gp2"
    delete_on_termination = true

    encrypted = true
  }

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = merge(local.project_tags)

  network_interface {
    network_interface_id = aws_network_interface.vpnw.id
    device_index         = 0
  }

  depends_on = [
    aws_network_interface.vpnw,
  ]


  lifecycle {
    ignore_changes = [ami]
  }

}

resource "aws_eip" "vpn_eip" {
  instance = aws_instance.vpn_wireguard.id
  vpc      = true
  depends_on = [
    aws_instance.vpn_wireguard,
  ]
}
