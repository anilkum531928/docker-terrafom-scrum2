# Find the latest Amazon Linux 2023 AMI
data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "state"
    values = ["available"]
  }
}


# Create EC2 instance
resource "aws_instance" "docker_server" {

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  user_data = <<-EOF
              #!/bin/bash

              # Update packages
              dnf update -y

              # Install Docker
              dnf install -y docker

              # Start Docker
              systemctl start docker

              # Enable Docker after reboot
              systemctl enable docker

              # Add ec2-user to docker group
              usermod -aG docker ec2-user

              # Verify Docker service
              systemctl is-active docker > /tmp/docker-status.txt

              # Store Docker version
              docker --version > /tmp/docker-version.txt
              EOF

  tags = {
    Name = "terraform-docker-server"
  }
}