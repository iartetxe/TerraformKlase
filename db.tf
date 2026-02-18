resource "aws_db_subnet_group" "rds_subnet" {

    name = "mysql-subnet"
    description = "Conjunto de subredes"
    subnet_ids = [aws_subnet.subnet1.id, aws_subnet.subnet2.id] 
  
}

resource "aws_db_parameter_group" "rds_parameter" {

    name = "rds-mysql"
    family = "mysql5.7"

    parameter {
      name = "character_set_server"
      value = "utf8"
    }
    parameter {
      name = "character_set_client"
      value = "utf8"
    }

  
}
resource "aws_db_instance" "mi-db" {

    allocated_storage = 10
    db_name = "mymysql"
    engine = "mysql"
    engine_version = "5.7"
    instance_class = "db.t3.micro"
    username = "admin1234"
    password = "admin1234"
    db_subnet_group_name = aws_db_subnet_group.rds_subnet.name
    parameter_group_name = aws_db_parameter_group.rds_parameter.name
    vpc_security_group_ids = [aws_security_group.mysql.id]
    availability_zone = aws_subnet.subnet1.availability_zone
}