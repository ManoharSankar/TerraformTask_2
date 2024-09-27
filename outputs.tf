# Output the public IP of the first EC2 instance 
output "nginx_instance_1_public_ip" {
  description = "The public IP of the first NGINX instance"
  value       = aws_instance.nginx_instance_1.public_ip
}

# Output the public IP of the second EC2 instance 
output "nginx_instance_2_public_ip" {
  description = "The public IP of the second NGINX instance"
  value       = aws_instance.nginx_instance_2.public_ip
}

