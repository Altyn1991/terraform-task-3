resource "aws_instance" "wordpress" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = var.public_subnet_id
  vpc_security_group_ids = [var.security_group_id]
  key_name      = var.key_name

user_data = <<-EOF
  #!/bin/bash
  yum update -y
  amazon-linux-extras enable php8.0
  yum clean metadata
  yum install -y httpd wget unzip php php-mysqlnd
  systemctl enable httpd
  systemctl start httpd
  cd /var/www/html
  wget https://wordpress.org/latest.zip
  unzip latest.zip
  mv wordpress/* /var/www/html/
  rm -rf wordpress
  chown -R apache:apache /var/www/html
  systemctl restart httpd
EOF


  tags = {
    Name = "wordpress-ec2"
  }
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

