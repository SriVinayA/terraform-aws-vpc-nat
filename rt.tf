resource "aws_route_table" "public_rt" {
    vpc_id = aws_vpc.vpc-01.id

    route {
        cidr_block = var.all_ipv4_cidr
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "public-${random_pet.vinay_pet.id}"
    }
}

resource "aws_default_route_table" "private_rt" {
    default_route_table_id = aws_vpc.vpc-01.default_route_table_id

    route {
        cidr_block = var.all_ipv4_cidr
        nat_gateway_id = aws_nat_gateway.nat_gw.id
    }

    tags = {
        Name = "private-${random_pet.vinay_pet.id}"
    }
}