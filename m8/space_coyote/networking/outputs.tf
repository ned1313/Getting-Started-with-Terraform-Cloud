output "vpc_id" {
  description = "VPC id for Space Coyote"
  value       = aws_vpc.space_coyote.id
}

output "subnet_id" {
  description = "Subnet id for Space Coyote"
  value       = aws_subnet.space_coyote.id
}