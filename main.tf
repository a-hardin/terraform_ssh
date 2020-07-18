variable "region" {
    default    = "us-east-2"
}
variable "profile" {
    default    = "default"
}
variable "ssh_public_key_path" {
    default    = "~/.ssh/id_rsa.pub"
}
variable "ssh_private_key_path" {
    default    = "~/.ssh/id_rsa"
}
variable "ami_id" {
    default    = "ami-0a63f96e85105c6d3"
}
variable "public_ip_address" {
    default    = "0.0.0.0/0"
}

provider "aws" {
  profile = var.profile
  region  = var.region
}

resource "aws_key_pair" "key" {
  key_name   = "ssh_example_key"
  public_key = file(var.ssh_public_key_path)
}

resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow Ssh inbound traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.public_ip_address]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_instance" "ssh_example" {
  key_name      = aws_key_pair.key.key_name
  ami           = var.ami_id
  instance_type = "t2.micro"
  security_groups = [aws_security_group.allow_ssh.name]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.ssh_private_key_path)
    host        = self.public_ip
  }

  provisioner "local-exec" {
    command = "echo ssh ubuntu@${aws_instance.ssh_example.public_ip} > ssh_info.txt"
  }
}