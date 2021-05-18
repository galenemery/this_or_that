terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }

  required_version = ">= 0.14.9"
}

provider "aws" {
  profile = "lacework"
  region  = "us-west-2"
}

resource "aws_instance" "server_01" {
  ami           = "ami-0cf6f5c8a62fa5da6"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  key_name = "galen-lacework"
  subnet_id = "subnet-06f0e06203942b65a"
  vpc_security_group_ids = ["sg-06640da4306cdd7f7","sg-0a00862363996c204"]
  depends_on = [
    aws_instance.server_03
  ]

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo mkdir /app",
      "sudo chmod 777 /app"
    ]  
  }

  provisioner "file" {
    source      = "vote/vote"
    destination = "/app/vote"
  }

  provisioner "file" {
      source = "files/scripts"
      destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/scripts/setup_python.sh",
      "/tmp/scripts/setup_python.sh",
    ]  
  }

  tags = {
    Name    = "server_01",
    Owner   = "galen.emery@lacework.net",
    Purpose = "Customer PoC Testing"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/users/galen/gdrive/keys/galen-lacework.pem")
    host        = self.public_ip
  }
}

resource "aws_instance" "server_03" {
  ami           = "ami-0cf6f5c8a62fa5da6"
  associate_public_ip_address = true
  instance_type = "t2.micro"
  key_name = "galen-lacework"
  subnet_id = "subnet-06f0e06203942b65a"
  vpc_security_group_ids = ["sg-06640da4306cdd7f7","sg-0a00862363996c204"]
  private_ip = "10.0.0.50"

  provisioner "file" {
      source = "files/scripts"
      destination = "/tmp"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/scripts/setup_03.sh",
      "sudo /tmp/scripts/setup_03.sh",
    ]  
  }

  tags = {
    Name    = "server_03",
    Owner   = "galen.emery@lacework.net",
    Purpose = "Customer PoC Testing"
  }

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("C:/users/galen/gdrive/keys/galen-lacework.pem")
    host        = self.public_ip
  }
}