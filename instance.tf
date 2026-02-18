data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"

    key_name = aws_key_pair.niregiltza.key_name

    subnet_id = aws_subnet.subnet1.id

  vpc_security_group_ids = [aws_security_group.denabaimendu.id]


  tags = {
    Name = "HelloWorld"
  }

  user_data = file("./userdata.sh")
}
resource "aws_key_pair" "niregiltza" {
    key_name = "niregiltza-aws"
    public_key = file("./giltza.pub")
  
}

output "ec2-public_key" {
  value = aws_instance.example.public_ip
}