variable "region" {
  description = "Default region"
  default = "us-east-1"
}

variable "instance_type" {
  description = "Instance type"
  default = "t2.nano"
}

variable "ami" {
  description = "Image AMI"
  default = "ami-0b33d91d"
}

variable "test_id" {
  description = "ID of test"
}
