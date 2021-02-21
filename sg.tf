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