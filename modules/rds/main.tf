resource "aws_db_subnet_group" "this" {
  name       = "rds-subnet-group"
  subnet_ids = var.private_subnets
  tags = { Name = "rds-subnet-group" }
}

resource "aws_db_instance" "mysql" {
  identifier              = "mysql-wp"
  allocated_storage       = 20
  storage_type            = "gp2"
  engine                  = "mysql"
  instance_class          = "db.t3.micro"
  username                = "admin"
  password                = "adminadmin"
  skip_final_snapshot     = true
  vpc_security_group_ids  = [var.rds_sg_id]
  db_subnet_group_name    = aws_db_subnet_group.this.name
  publicly_accessible     = false

  tags = { Name = "mysql-db" }
}

