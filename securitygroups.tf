resource "aws_security_group" "FrontEnd" {
  name = "FrontEnd"
  tags {
        Name = "FrontEnd"
  }
  description = "ONLY HTTP CONNECTION INBOUD"
  vpc_id = "${aws_vpc.terraformmain.id}"

  ingress {
        from_port = 80
        to_port = 80
        protocol = "TCP"
        cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "22"
    to_port     = "22"
    protocol    = "TCP"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "Database" {
  name = "Database"
  tags {
        Name = "Database"
  }
  description = "ONLY tcp CONNECTION INBOUND"
  vpc_id = "${aws_vpc.terraformmain.id}"
  ingress {
      from_port = 3306
      to_port = 3306
      protocol = "TCP"
      security_groups = ["${aws_security_group.FrontEnd.id}"]
  }
  ingress {
      from_port   = "22"
      to_port     = "22"
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
