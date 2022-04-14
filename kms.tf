resource ibm_container_cluster "tfcluster" {
    name            = "tfclusterdoc"
    datacenter      = "dal10"
    machine_type    = "b3c.4x16"
    hardware        = "shared"
    public_vlan_id  = "2234945"
    private_vlan_id = "2234947"

    kube_version = "1.21.9"

    default_pool_size = 3
        
    public_service_endpoint  = "true"
    private_service_endpoint = "true"

    resource_group_id = data.ibm_resource_group.rg.id
}

# Making the KMS multi-zone

resource "ibm_container_worker_pool_zone_attachment" "dal12" {
    cluster         = ibm_container_cluster.tfcluster.id
    worker_pool     = ibm_container_cluster.tfcluster.worker_pools.0.id
    zone            = "fra01"
    # private_vlan_id = "<private_vlan_ID_dal12>"
    # public_vlan_id  = "<public_vlan_ID_dal12>"
    resource_group_id = data.ibm_resource_group.rg.id
}

resource "ibm_container_worker_pool_zone_attachment" "dal13" {
    cluster         = ibm_container_cluster.tfcluster.id
    worker_pool     = ibm_container_cluster.tfcluster.worker_pools.0.id
    zone            = "fra02"
    # private_vlan_id = "<private_vlan_ID_dal13>"
    # public_vlan_id  = "<public_vlan_ID_dal13>"
    resource_group_id = data.ibm_resource_group.rg.id
}

# Adding workerpools

resource "ibm_container_worker_pool" "workerpool" {
    worker_pool_name = "tf-workerpool"
    machine_type     = "u3c.2x4"
    cluster          = ibm_container_cluster.tfcluster.id
    size_per_zone    = 2
    hardware         = "shared"

    resource_group_id = data.ibm_resource_group.rg.id
}

resource "ibm_container_worker_pool_zone_attachment" "tfwp-dal10" {
    cluster         = ibm_container_cluster.tfcluster.id
    worker_pool     = element(split("/", ibm_container_worker_pool.workerpool.id),1)
    zone            = "fra01"
    # private_vlan_id = "<private_vlan_ID_dal10>"
    # public_vlan_id  = "<public_vlan_ID_dal10>"
    resource_group_id = data.ibm_resource_group.rg.id
}

resource "ibm_container_worker_pool_zone_attachment" "tfwp-dal12" {
    cluster         = ibm_container_cluster.tfcluster.id
    worker_pool     = element(split("/", ibm_container_worker_pool.workerpool.id),1)
    zone            = "fra02"
    # private_vlan_id = "<private_vlan_ID_dal12>"
    # public_vlan_id  = "<public_vlan_ID_dal12>"
    resource_group_id = data.ibm_resource_group.rg.id
}



# Unfortunately, it is now possible to provision a test-cluster
# in the free tier via the IBM Cloud Schematics.

# resource "ibm_container_vpc_cluster" "cluster" {
#   name              = "mycluster"
#   vpc_id            = ibm_is_vpc.vpc.id
#   flavor            = "bx2-4x16"
#   worker_count      = 3
#   resource_group_id = data.ibm_resource_group.rg.id
#   zones {
#     subnet_id = ibm_is_subnet.subnet1.id
#     name      = "us-south-1"
#   }# 

#   depends_on = [
#      ibm_is_vpc.vpc
#   ]
# }# 

# resource "ibm_container_vpc_worker_pool" "cluster_pool" {
#   cluster           = ibm_container_vpc_cluster.cluster.id
#   worker_pool_name  = "mywp"
#   flavor            = "bx2-2x8"
#   vpc_id            = ibm_is_vpc.vpc.id
#   worker_count      = 3
#   resource_group_id = data.ibm_resource_group.rg.id
#   zones {
#     name      = "us-south-2"
#     subnet_id = ibm_is_subnet.subnet2.id
#   }
#   depends_on = [
#      ibm_is_vpc.vpc
#   ]
# }