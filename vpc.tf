resource "aws_vpc" "vpc_proyecto" {
    cidr_block = "11.11.0.0/16"
    enable_dns_hostnames = true

    tags = {
        Name = "VPC_NextCloud"
    }
}

resource "aws_subnet" "subnet_proyecto" {
    vpc_id = aws_vpc.vpc_proyecto.id
    cidr_block = "11.11.1.0/24"
    availability_zone = "us-east-1c"

    tags = {
        Name = "Subnet_NextCloud"
    }

}

resource "aws_subnet" "subnet_2_proyecto" {
    vpc_id = aws_vpc.vpc_proyecto.id
    cidr_block = "11.11.2.0/24"
    availability_zone = "us-east-1b"

    tags = {
        Name = "Subnet_NextCloud2"
    }

}

resource "aws_internet_gateway" "gw_proyecto" {
    vpc_id = aws_vpc.vpc_proyecto.id

    tags={
        Name = "Gw_NextCloud"
    }

}


resource "aws_route_table" "rt_default_proyecto" {
    vpc_id = aws_vpc.vpc_proyecto.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.gw_proyecto.id
    }

    tags = {
        Name = "rt_default_NextCloud"
    }

}

resource "aws_route_table_association" "a_rt_default_proyecto" {
    subnet_id = aws_subnet.subnet_proyecto.id
    route_table_id = aws_route_table.rt_default_proyecto.id

}

resource "aws_db_subnet_group" "rds" {
  name       = "rds_nextcloud"
  subnet_ids  = [aws_subnet.subnet_proyecto.id,aws_subnet.subnet_2_proyecto.id ]

  tags = {
    Name = "Subnet group RDS"
  }
}

