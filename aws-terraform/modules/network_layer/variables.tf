variable "bastion_key_pair_name" {
    type = string
    description = "Name of keypair to use for the Bastion"
}

variable "private_domain_name" {
    type = string
    description = "Private domain name. ie: testytesty.internal"
}
