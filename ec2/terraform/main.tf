provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "desafio_keypair" {
  key_name   = "keypair-desafio"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_security_group" "desafio_sg" {
  name        = "desafio-sg"
  description = "Habilitar ssh, http e https para anywhere"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # -1 libera todas as portas e protocolos
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "frontend" {
  ami           = "ami-0c614dee691cbbf37"
  instance_type = "t2.micro"

  security_groups = [aws_security_group.desafio_sg.name]
  key_name        = aws_key_pair.desafio_keypair.key_name

  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
  }

  user_data = file("frontend.sh")

  tags = {
    Name = "frontend"
  }
}

resource "aws_instance" "backend" {
  ami           = "ami-0c614dee691cbbf37"  # Substitua pela AMI correta
  instance_type = "t2.micro"

  security_groups = [aws_security_group.desafio_sg.name]
  key_name        = aws_key_pair.desafio_keypair.key_name

  associate_public_ip_address = true

  root_block_device {
    volume_type           = "gp3"
    volume_size           = 20
    delete_on_termination = true
  }

  user_data = file("backend.sh")

  tags = {
    Name = "backend"
  }
}