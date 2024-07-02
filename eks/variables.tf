variable "region" {
  description = "AWS Region"
  default     = "eu-central-1"
}

variable "workspace_profiles" {
  description = "AWS profile"
  default     = "test"
}

variable "app_max_size" {
  description = "Desired amount of node in application node group"
  default = {
    dev  = "5"
    prod = "5"
  }
}

variable "app_min_size" {
  description = "Minimum amount of node in application node group"
  default = {
    dev  = "3"
    prod = "3"
  }
}

variable "create_kms_key" {
  description = "Instance type in application node group"
  default = {
    dev  = "false"
    prod = "true"
  }
}

variable "instance_type" {
  description = "Instance type in application node group"
  default = {
    dev  = "t3.2xlarge"
    prod = "t3.4xlarge"
  }
}

variable "office_ipv4" {
  description = "List of Clowdflare ipv4 addresses"
  default = [
    "35.159.151.129/32"
  ]
}

variable "clowdflare_ipv4" {
  description = "List of Clowdflare ipv4 addresses"
  default = [
    "173.245.48.0/20",
    "103.21.244.0/22",
    "103.22.200.0/22",
    "103.31.4.0/22",
    "141.101.64.0/18",
    "108.162.192.0/18",
    "190.93.240.0/20",
    "188.114.96.0/20",
    "197.234.240.0/22",
    "198.41.128.0/17",
    "162.158.0.0/15",
    "104.16.0.0/12",
    "172.64.0.0/13",
    "131.0.72.0/22",
    "52.59.73.87/32",
    "35.157.14.176/32",
    "52.29.7.216/32",
    "52.29.248.104/32",
    "52.28.129.38/32",
    "35.158.45.172/32",
    "104.16.0.0/13",
    "104.24.0.0/14"
  ]
}
