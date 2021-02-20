provider "aws" {
    version = "2.31.0"
}

resource "aws_route53_zone" "terraform_aws" {
    name = "terraform-aws.bxgrzesiek.pl"
}

output "terraform_aws_ns" {
    value = "${aws_route53_zone.terraform_aws.name_servers}"
}

resource "aws_route53_record" "instance" {
    zone_id = "${aws_route53_zone.terraform_aws.zone_id}"
    name = "terraform-aws.bxgrzesiek.pl"
    type = "A"
    ttl = "300"
    records = ["${aws_instance.instance.public_ip}"]
}

resource "aws_security_group" "http_ssh" {
    name = "http_ssh"

    # in for My IP for SSH
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        # warning! check if Your IP is static
        cidr_blocks = ["188.146.96.73/32"]
    }

    # in for everyone for http
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # out for everyone
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_key_pair" "admin" {
    key_name = "admin public key"
    public_key = "${file("admin.pub")}"
}

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