# network.tf without elp

data "aws_vpc" "main" {
  filter {
    name = "tag:Name"
    values = ["dev-data-stream-vpc"]
  }
}


data "aws_subnet" "public_1a" {
  filter {
    name = "tag:Name"
    values = ["dev-data-stream-public-subnet"]
  }

  filter {
    name = "availability-zone"
    values = ["ap-southeast-1a"]  # check zone
  }
}

data "aws_subnet" "public_1b" {
  filter {
    name = "tag:Name"
    values = ["dev-data-stream-public-subnet"]
  }

  filter {
    name = "availability-zone"
    values = ["ap-southeast-1b"]   # check zone
  }
}


data "aws_subnet" "public_1c" {
  filter {
    name = "tag:Name"
    values = ["dev-data-stream-public-subnet"]
  }

  filter {
    name = "availability-zone"
    values = ["ap-southeast-1c"] # check zone
  }
}

# print vpc and subnet ids
output "aws_vpc_name" {
  value = data.aws_vpc.main.id
}

output "aws_subnet_1a" {
  value =  data.aws_subnet.public_1a.id
}

output "aws_subnet_1b" {
  value = data.aws_subnet.public_1b.id
}

output "aws_subnet_1c" {
  value = data.aws_subnet.public_1c.id
}
