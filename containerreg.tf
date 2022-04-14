resource "ibm_cr_namespace" "cr_namespace" {
    name = local.cr_namespace
    resource_group_id = data.ibm_resource_group.rg.id
}

resource "ibm_cr_retention_policy" "cr_retention_policy" {
    namespace = ibm_cr_namespace.cr_namespace.id
    images_per_repo = 10
}

resource "ibm_iam_user_policy" "registry_policy" {
    ibm_id = var.user_name_iam
    roles  = ["Manager"]

    resources {
        service = "container-registry"
        resource = ibm_cr_namespace.cr_namespace.id
        resource_type = "namespace"
        region = var.region
    }
}