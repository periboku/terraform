provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "yaramiyeooo" {
  ami = "ami-0499632f10efc5a62"
  instance_type = "t2.micro"
  tags = {
    Name = "yaramiyeo"
  }
}