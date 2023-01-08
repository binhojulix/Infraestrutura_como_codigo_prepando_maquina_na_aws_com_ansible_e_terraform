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

resource "aws_security_group" "acesso_8080" {
  name        = "acesso_8080"
  ingress {
    from_port        = 8080
    to_port          = 8080
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
    tags = {
    Name = "http"
  }
}


resource "aws_instance" "dev" {
  ami = "ami-06878d265978313ca"
  instance_type = "t2.micro"
  key_name = "terraform_aws"
  user_data = <<-EOF
        #!/bin/bash
        cd /home/ubuntu
        echo "<h1> Feito com terraform</h1>" > index.html
        nohup busybox httpd -f -p 8080 &
    EOF
  tags = {
    Name = "dev"
  }
  vpc_security_group_ids = ["${aws_security_group.acesso_ssh.id}",
  "${aws_security_group.acesso_8080.id}"]

}
