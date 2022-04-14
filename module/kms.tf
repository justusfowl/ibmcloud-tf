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