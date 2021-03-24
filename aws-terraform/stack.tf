module "network_layer" {
  source = "./modules/network_layer"

  bastion_key_pair_name = aws_key_pair.key_pair_for_everything.key_name
  private_domain_name   = var.private_domain_name
}

# TODO: use DHCP Options in future
locals {
  sets = [{
    name              = "set1"
    private_ip_server = "10.0.1.4"
    private_ip_client = "10.0.1.5"
    }, {
    name              = "set2"
    private_ip_server = "10.0.1.14"
    private_ip_client = "10.0.1.15"
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
