provider "aws" {
  version = "~> 4.0"
  region  = "us-east-1"
}
 

resource "aws_security_group" "acesso_ssh" {
  name        = "acesso-sh"
  description = "acesso-sh" 
  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = var.cdris_acesso_remoto
  }
  tags = {
    Name = "ssh"
  }
}

resource "aws_instance" "dev" {
  count = 3
  ami = "ami-06878d265978313ca"
  instance_type = "t2.micro"
  key_name = "terraform_aws"
  tags = {
    Name = "dev${count.index}"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}"]

}
