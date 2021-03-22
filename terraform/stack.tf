module "network_layer" {
  source = "./modules/network_layer"

  bastion_key_pair_name = aws_key_pair.key_pair_for_everything.key_name
}

# TODO: Hackey... but easier than writing an algorithm to calculate the ips. Use DHCP options in future. 
locals {
  sets = [{
    name       = "set1"
    private_ip = "10.0.1.4"
    }, {
    name       = "set2"
    private_ip = "10.0.1.5"
  }]
}

module "machine_layer" {
  source = "./modules/machine_set"

  depends_on = [module.network_layer]

  key_pair_name = aws_key_pair.key_pair_for_everything.key_name
  network_layer = module.network_layer.network_layer

  count = length(local.sets)

  set = local.sets[count.index]
}
