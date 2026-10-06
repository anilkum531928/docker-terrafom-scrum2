output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.docker_server.id
}

output "public_ip" {
  description = "EC2 public IP"
  value       = aws_instance.docker_server.public_ip
}

output "public_dns" {
  description = "EC2 public DNS"
  value       = aws_instance.docker_server.public_dns
}

output "docker_server_name" {
  description = "EC2 Name tag"
  value       = aws_instance.docker_server.tags["Name"]
}