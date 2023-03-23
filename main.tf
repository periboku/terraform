provider "aws" {
    region = "eu-central-1"
}






#########RESOURCES#################

resource "aws_instance" "yaramiyeooo" {
    ami                     = "ami-0499632f10efc5a62"
    instance_type           = "t2.micro"
    vpc_security_group_ids = [aws_security_group.terraformSg.id]
    
   # user_data = <<-EOF 
   #             #!/bin/bash
   #             echo "Hello World!" > index.html
   #             nohup busybox httpd -f -p $[var.server_port] &
   #             EOF

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



resource "aws_launch_configuration" "yukleme_conf" {
    image_id = aws_instance.yaramiyeooo.ami
    instance_type = aws_instance.yaramiyeooo.instance_type
    security_groups = [aws_security_group.terraformSg.id]
    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "otoskeyil" {
    launch_configuration = aws_launch_configuration.yukleme_conf.name
    min_size = 2
    max_size = 5

    tag {
      key = "Name"
      value = "terraform_asg_ornegi"
      propagate_at_launch = true
    }
}


resource "aws_lb" "loadbalancerim" {
  name = "otoscaleloadbalancer"
  load_balancer_type = "application"
  subnets = [data.aws_subnets.benimSubnetler.id]
}

resource "aws_lb_listener" "http" {
    load_balancer_arn = aws_lb.loadbalancerim.arn
    port = 80
    protocol = "HTTP"

    default_action {
        type = "fixed-response"

        fixed_fixed_response {
          content_type = "text/plain"
          message_body = "404:sayfa yok"
          status_code = 404
        }        
    }
}



#########################









###########DATA############

data "aws_vpc" "temel" {
    default = true
}


data "aws_subnets" "benimSubnetler" {

}
###############################












############OUTPUTS#############

output "dis_ip" {
    value = aws_instance.yaramiyeooo.public_ip
    description = "bizim makinanın public ip'si"
}


output "sgismi" {
    value = aws_security_group.terraformSg.arn
    description = "kullanılan sg'nin ismi"
  
}


output "vpcaydi" {
  value = data.aws_vpc.temel.id
}


output "sabnetler"{
    value = data.aws_subnets.benimSubnetler
}

################################






















###### VARIABLES ####################

variable "server_port" {
    description = "http request için server portu"
    type = number
    default = 8080
}

####################################