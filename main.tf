provider "aws" {
    region = "eu-central-1"
}

resource "aws_instance" "yaramiyeooo" {
    ami                     = "ami-0499632f10efc5a62"
    instance_type           = "t2.micro"
    vpc_security_group_ids = [aws_security_group.terraformSg.id]
    
    #user_data = <<-EOF 
                #!/bin/bash
    #            echo "Hello World!" > index.html
    #            nohup busybox httpd -f -p 8080 &
    #            EOF

    tags = {
        Name = "yaramiyeo"
  }
}

resource "aws_security_group" "terraformSg" {
    name = "terraform-tutorial-seksenseksen"

    ingress {
        from_port   = var.server_port
        to_port     = var.server_port
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"] 
    }
}

variable "server_port" {
    description = "http request için server portu"
    type = number
    default = 8080
}