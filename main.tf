data "template_file" "user_data" {
  template = file("setup.yml")
}
provider "aws" {}
#you must have creds in environment
#PS C:\> $Env:AWS_ACCESS_KEY_ID=" "
#PS C:\> $Env:AWS_SECRET_ACCESS_KEY=" "
#PS C:\> $Env:AWS_DEFAULT_REGION=" "
#ssh key
#ssh key terraform_key must exist in aws
#point this at the private key about line 25
resource "random_pet" "name" {}
resource "aws_instance" "webjson_server" {
  ami           = "ami-05d7cb15bfbf13b6d"
  instance_type = "t2.micro"
  key_name = "terraform_key"
  vpc_security_group_ids = [aws_security_group.ssh-sg.id]
  user_data = data.template_file.user_data.rendered
  tags = {
    Name = random_pet.name.id
  }
  #provisioner "file" {
  #  source      = "setup.sh"
  #  destination = "/tmp/setup.sh"
  #}
  #connection {
  #    type        = "ssh"
  #    user        = "centos"
  #    private_key = "${file("C:/users/bbowden/.ssh/keep/id_rsa")}"
  #    host        = "${self.public_dns}"
  #  }
  # Change permissions on bash script and execute from ec2-user.
  #provisioner "remote-exec" {
  #  inline = [
  #    "chmod +x /tmp/setup.sh",
  #    "sudo /tmp/setup.sh",
  #  ]
  #}
}
resource "aws_security_group" "ssh-sg" {
  name = "${random_pet.name.id}-sg"
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

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
}

