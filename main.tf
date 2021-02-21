provider "aws" {
    version = "2.31.0"
}

resource "aws_key_pair" "admin" {
    key_name = "admin public key"
    public_key = "${file("admin.pub")}"
}