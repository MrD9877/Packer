packer {
  required_plugins {
    amazon = {
      version = ">= 1.2.8"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

locals {
  timestamp = regex_replace(timestamp(), "[- TZ:]", "")
}

source "amazon-ebs" "packer-demo-image" {
  ami_name      = "packer-demo-${local.timestamp}"
  instance_type = "t2.micro"
  region        = "us-west-2"
  source_ami = "ami-06a974f9b8a97ecf2"
  # source_ami_filter {
  #   filters = {
  #     name                = "amzn2-ami-hvm-2.0.*-x86_64-gp2"
  #     root-device-type    = "ebs"
  #     virtualization-type = "hvm"
  #   }
  #   most_recent = true
  #   owners      = ["amazon"]
  # }
  ssh_username = "ec2-user"
}

build {
  name    = "learn-packer"
  sources = [
    "source.amazon-ebs.packer-demo-image"
  ]   

  provisioner "file" {
    source = "./packer.service"
    destination = "/tmp/packer.service"
   }

  provisioner "shell" {
     script = "./app.sh"
   }
}
