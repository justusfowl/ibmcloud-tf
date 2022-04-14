resource "ibm_resource_instance" "resource_instance" {
    name = "${random_string.random.result}-loginstance"
    service = "logdna"
    plan = "lite"
    location = var.region
    resource_group_id = data.ibm_resource_group.rg.id
    tags = ["logging", "public"]
    parameters = {
      default_receiver = true
    }
  }

  // Create the resource key that is associated with the instance

  resource "ibm_resource_key" "resourceKey" {
    name = "${var.env_prefix}-logdna-key"
    role = "Manager"
    resource_instance_id = ibm_resource_instance.resource_instance.id
  }

  // Add a user policy for using the resource instance

  resource "ibm_iam_user_policy" "policy" {
    ibm_id = var.user_name_iam
    roles  = ["Manager", "Viewer"]

    resources {
      service              = "logdna"
      resource_instance_id = element(split(":", ibm_resource_instance.resource_instance.id), 7)
    }
  }