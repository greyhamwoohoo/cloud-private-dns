variable "key_pair_name" {
    type = string
    description = "Name of keypair to use for the instances"
}

variable "network_layer" {
    type = map
    description = "The outputs from the network_layer"
}

variable "set" {
    type = map
    description = "The set parameters. "
}
