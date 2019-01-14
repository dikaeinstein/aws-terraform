provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

# New resource for s3 bucket 
resource "aws_s3_bucket" "example" {
  bucket = "terraform-learn-dika"
  acl    = "private"
}

resource "aws_instance" "terraform_learn" {
  ami           = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  provisioner "local-exec" {
    command = "echo ${aws_instance.terraform_learn.public_ip} > ip_address.txt"
  }

  # Tells Terraform that this EC2 instance must be created only after the
  # S3 bucket has been created.
  depends_on = ["aws_s3_bucket.example"]
}

resource "aws_eip" "ip" {
  instance = "${aws_instance.terraform_learn.id}"
}

output "ip" {
  value = "${aws_eip.ip.public_ip}"
}
