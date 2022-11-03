resource "aws_instance" "confluence" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id    = var.public_subnet
  key_name     = "aws_key"
  iam_instance_profile = aws_iam_instance_profile.confluence-iam-instance-profile.name
  user_data    = "${data.template_file.init.rendered}"
  tags  = var.tags
}

data "template_file" "init" {
  template = "${file("${path.module}/userdata.tpl")}"
}

resource "aws_security_group" "confluence" {
  name        = var.ec2_security_group_name
  description = var.ec2_security_group_description
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow traffic on port 80 from everywhere"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  tags = var.tags
}

resource "aws_lb" "confluence" {
  name               = "confluence-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.confluence.id]
  subnets            = [
    "${var.public_subnet}",
    "${var.private_subnet}",
  ]

  enable_deletion_protection = false
  tags = var.tags

}

resource "aws_iam_role_policy" "confluence-policy" {
  name = "confluence-policy"
  role = "${aws_iam_role.confluence_ssm_role.id}"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": "ssmmessages:*",
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role" "confluence_ssm_role" {
  name = "confluence_ssm_role"
  assume_role_policy = <<EOF
{
"Version": "2012-10-17",
"Statement": [
{
"Action": "sts:AssumeRole",
"Principal": {
 "Service": "ec2.amazonaws.com"
},
"Effect": "Allow"
}
]
}
EOF
  tags = {
    tag-key = "confluence-iam-role"
  }
}


resource "aws_iam_instance_profile" "confluence-iam-instance-profile" {
  name = "confluence-iam-instance-profile"
  role = "${aws_iam_role.confluence_ssm_role.name}"
}

resource "aws_iam_role_policy_attachment" "confluence-resources-ssm-policy" {
role       = aws_iam_role.confluence_ssm_role.name
policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_s3_bucket" "sw-packages" {
  bucket = "csw-packages"
}


resource "aws_eip" "confluenceeip" {
  vpc      = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.confluence.id
  allocation_id = aws_eip.confluenceeip.id
}
