# Provider configuration
provider "aws" {
  region = "ap-south-1"  # Update to your desired region
  version = "~> 4.0"  # Example version constraint
}

# Define the security group
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"

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

# Create the EC2 instance
resource "aws_instance" "my_ec2" {
  ami           = "ami-05c179eced2eb9b5b"  # Replace with a valid AMI ID for your region
  instance_type = "t2.micro"               # Instance type, for example, t2.micro
  key_name      = "mywebserver"       # The name of the key pair in AWS

  # Associate the security group
  security_groups = [aws_security_group.allow_ssh.test]

  # Tag the instance
  tags = {
    Name = "MyEC2InstanceUsingTF"
  }
}
