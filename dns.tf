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