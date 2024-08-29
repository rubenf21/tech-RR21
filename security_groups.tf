resource "aws_security_group" "sg_proyecto" {
    name = "SG Acceso Next Cloud"
    description = "Permte el acceso a la maquina Next Cloud"
    vpc_id = aws_vpc.vpc_proyecto.id

    tags = {
      Name = "SG_proyecto_acceso_SSH"
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Permite acceso puerto 22"
    }

    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Puerto 8080 NextCloud"
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
        description = "Permite salida a cualquier ip y puerto"
    }

}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.vpc_proyecto.id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Cambia esto para restringir el acceso
    description = "Puerto 3306 mysql"  
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
