# module outputs are not surfaced by default; we can propagate them like this
output "the_stack" {
  value = {
    network_layer = module.network_layer.network_layer
    machine_sets  = module.machine_layer[*].machine_set
  }
}
