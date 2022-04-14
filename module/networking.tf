resource "ibm_is_vpc" "vpc" {
  name = "myvpc"
  resource_group = data.ibm_resource_group.rg.id
}

resource "ibm_is_subnet" "subnet1" {
  name                     = "testsubnetone"
  vpc                      = ibm_is_vpc.vpc.id
  zone                     = var.region
  total_ipv4_address_count = 256
  depends_on = [
     ibm_is_vpc.vpc
  ]
}
