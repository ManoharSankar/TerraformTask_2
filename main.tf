# Provider for first region 
provider "aws" {
  region = var.region_1
}

# Provider for second region 
provider "aws" {
  alias  = "ap-southeast"
  region = var.region_2
}

# Create a Security Group for the first region
resource "aws_security_group" "nginx_sg_south" {
  name        = var.security_group_name_1
  description = "Allow HTTP traffic in ap-south-1"

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

# Create a Security Group for the second region 
resource "aws_security_group" "nginx_sg_southeast" {
  provider    = aws.ap-southeast
  name        = var.security_group_name_2
  description = "Allow HTTP traffic in ap-southeast-1"

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

# EC2 instance in the first region (us-east-1)
resource "aws_instance" "nginx_instance_1" {
  ami           = var.ami_south
  instance_type = var.instance_type

  # Attach the security group for the first region
  vpc_security_group_ids = [aws_security_group.nginx_sg_south.id]

  # User data to install NGINX
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo systemctl start nginx
              EOF

  tags = {
    Name = "NginxInstance1"
  }
}

# EC2 instance in the second region 
resource "aws_instance" "nginx_instance_2" {
  provider      = aws.ap-southeast
  ami           = var.ami_southeast
  instance_type = var.instance_type

  # Attach the security group for the second region
  vpc_security_group_ids = [aws_security_group.nginx_sg_southeast.id]

  # User data to install NGINX
  user_data = <<-EOF
              #!/bin/bash
              sudo apt update -y
              sudo apt install nginx -y
              sudo systemctl start nginx
              EOF

  tags = {
    Name = "NginxInstance2"
  }
}

