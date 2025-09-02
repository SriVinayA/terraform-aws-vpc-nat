resource "aws_eip" "nat_eip" {
    domain = "vpc"

    tags = {
        Name = "${random_pet.vinay_pet.id}-nat"
    }
}

resource "aws_eip" "windows_eip" {
    domain = "vpc"

    tags = {
        Name = "${random_pet.vinay_pet.id}-windows"
    }
}