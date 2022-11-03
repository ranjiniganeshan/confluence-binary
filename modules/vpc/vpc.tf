data "aws_availability_zones" "available" {}

resource "aws_vpc" "confluence" {
  cidr_block       = var.cidr_block
  tags  = var.tags
}

resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.confluence.id
  cidr_block = var.subnet1_cidr
  availability_zone = data.aws_availability_zones.available.names[0]
  tags  = var.tags
}

resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.confluence.id
  cidr_block = var.subnet2_cidr
  availability_zone = data.aws_availability_zones.available.names[1]
  tags  = var.tags
}

resource "aws_internet_gateway" "confluenceigw" {
  vpc_id = aws_vpc.confluence.id
  tags  = var.tags  
}

resource "aws_route_table" "publicrtb" {
  vpc_id = aws_vpc.confluence.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.confluenceigw.id
  }
   tags = var.tags 
}

resource "aws_route_table" "privatertb" {
  vpc_id = aws_vpc.confluence.id
   route {
    nat_gateway_id = "${aws_nat_gateway.confluence-nat-gateway.id}"
    cidr_block     = "0.0.0.0/0"
  }
   tags = var.tags 
}


resource "aws_route_table_association" "publicrtbasso" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.publicrtb.id
}


resource "aws_route_table_association" "privatertbasso" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.privatertb.id
}


resource "aws_eip" "nat-eip" {
  vpc = true
}

resource "aws_nat_gateway" "confluence-nat-gateway" {
  allocation_id = "${aws_eip.nat-eip.id}"
  subnet_id     = "${aws_subnet.private_subnet.id}"
}

