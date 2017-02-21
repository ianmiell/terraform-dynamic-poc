resource "aws_instance" "dynamic_environment" {
  tags {
    name = "ec2_instance_${var.test_id}"
  }
}
