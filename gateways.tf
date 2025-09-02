resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc-01.id

    tags = {
        Name = "IGW-${random_pet.vinay_pet.id}"
    }
}

resource "aws_nat_gateway" "nat_gw" {
    subnet_id = aws_subnet.public_subnet.id
    allocation_id = aws_eip.nat_eip.id

    tags = {
        Name = "NAT-${random_pet.vinay_pet.id}"
    }
}