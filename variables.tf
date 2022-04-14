variable "ibmcloud_api_key" {
    type = string
}

variable "region" {
    type = string
}

variable "env_prefix" {
    type = string
}

variable "rg_name" {
    type = string
}

variable "user_name_iam" {
    type = string
    description = "The user name used for the IAM assignment, such as EXAMPLE@ibm.com"
}

variable "ssh_key_name" {
    type = string
}