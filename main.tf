provider "aws" {}
#you must have creds in environment
#PS C:\> $Env:AWS_ACCESS_KEY_ID=" "
#PS C:\> $Env:AWS_SECRET_ACCESS_KEY=" "
#PS C:\> $Env:AWS_DEFAULT_REGION=" "
#ssh key
#ssh key terraform_key must exist in aws
resource "random_pet" "name" {}
resource "aws_instance" "webjson_server" {
  ami           = "ami-05d7cb15bfbf13b6d"
  instance_type = "t2.micro"
  key_name = "terraform_key"
  vpc_security_group_ids = [aws_security_group.ssh-sg.id]
  tags = {
    Name = random_pet.name.id
  }
}
resource "aws_security_group" "ssh-sg" {
  name = "${random_pet.name.id}-sg"
  ingress {
    from_port   = 22
    to_port     = 22
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


