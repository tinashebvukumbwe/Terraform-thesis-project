terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  
}



resource "aws_instance" "example_server" {
  ami           = "ami-04dfd853d88e818e8"
  instance_type = "t2.micro"

  tags = {
    Name = "firstone"
  }
}
