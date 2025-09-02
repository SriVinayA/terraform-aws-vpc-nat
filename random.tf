resource "random_pet" "vinay_pet" {
    length = 3 
}

resource "random_password" "vinay_password" {
    length = 15
    special = true
}

resource "random_id" "vinay_id" {
    byte_length = 8
}

resource "random_integer" "vinay_int" {
    min = 10
    max = 100
}

resource "random_string" "vinay_str" {
    length = 10
    upper = true
    special = true
}

resource "random_uuid" "vinay_uuid" {

}

resource "random_shuffle" "random_region" {
  input        = ["us-east-1", "us-east-2"]
  result_count = 1
}