output "vpc_id" { value = aws_vpc.main.id }
output "public_subnet_ids" { value = [for subnet in aws_subnet.public : subnet.id] }
output "private_subnet_ids" { value = [for subnet in aws_subnet.private : subnet.id] }
output "igw_id" { value = aws_internet_gateway.igw.id }
output "public_rt_id" { value = aws_route_table.public.id }
output "nat_gateway_ids" { value = [for nat in aws_nat_gateway.nat : nat.id] }
output "web_sg_id" { value = aws_security_group.web_sg.id }
output "public_nacl_id" { value = aws_network_acl.public_nacl.id }
