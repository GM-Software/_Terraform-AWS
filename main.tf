provider "aws" {
    version = "2.31.0"
}

resource "aws_route53_zone" "kd-zsf" {
    name = "kd-zsf.szkoladevops.com"
}

output "kd_zsf_ns" {
    value = "${aws_route53_zone.kd_zsf_ns.name_servers}"
}