variable "region" {
  description = "AWS Region"
  default     = "eu-central-1"
}

variable "workspace_profiles" {
  description = "AWS profile"
  default     = "test"
}

variable "id" {
  description = "Project name"
  default     = "test"
}

variable "vpc_cidr" {
  default = {
    dev  = "10.10.0.0/20"
    prod = "10.20.0.0/20"
    test = "10.30.0.0/20"
  }
}

variable "vpc_secondary_cidrs" {
  default = {
    dev  = ["100.64.0.0/16"]
    prod = ["100.74.0.0/16"]
    test = ["100.84.0.0/16"]
  }
}
