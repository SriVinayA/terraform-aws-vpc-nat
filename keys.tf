# Generate a private key
resource "tls_private_key" "vinay_key_pair" {
    algorithm = "RSA"
    rsa_bits  = 2048
}

# Upload public key to AWS
resource "aws_key_pair" "vinay_key_pair" {
    key_name   = "${random_pet.vinay_pet.id}_windows"
    public_key = tls_private_key.vinay_key_pair.public_key_openssh
}

# Save private key locally
resource "local_file" "vinay_key_pair_private" {
    filename = "${random_pet.vinay_pet.id}_private.pem"
    content  = tls_private_key.vinay_key_pair.private_key_pem
}

# Save public key locally
resource "local_file" "vinay_key_pair_public" {
    filename = "${random_pet.vinay_pet.id}_public.pem"
    content  = tls_private_key.vinay_key_pair.public_key_pem
}
