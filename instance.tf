# create instance
resource "aws_instance" "instance" {
    availability_zone = "eu-central-1b"
    # AMI - Image ID from which instance will be created
    ami = "ami-0c94affa248a89395"
    instance_type = "t2.nano"
    key_name = "${aws_key_pair.admin.key_name}"

    root_block_device {
        volume_size = "10"
    }

    vpc_security_group_ids = ["${aws_security_group.http_ssh.id}"]

    tags = {
        Name = "Test instance for Terraform on AWS"
    }
}

output "instance_public_ip" {
    value = "${aws_instance.instance.public_ip}"
}