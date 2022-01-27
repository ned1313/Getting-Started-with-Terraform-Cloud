output "space_coyote_url" {
  value = "http://${aws_eip.space_coyote.public_dns}"
}

output "space_coyote_ip" {
  value = "http://${aws_eip.space_coyote.public_ip}"
}