provider "aws" {
  region = "us-west-2"  # Change this to your desired region
}

resource "aws_instance" "app_server" {
  ami           = "ami-0c55b159cbfafe1f0" # Update this with the latest Amazon Linux AMI
  instance_type = "t2.micro"

  tags = {
    Name = "PythonAppServer"
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              service docker start
              docker run -d -p 5000:5000 --name my-python-app my-python-app:latest

}

output "instance_ip" {
  value = aws_instance.app_server.public_ip
}
