resource "ibm_resource_instance" "cos_instance" {
  name              = "cos-instance"
  resource_group_id = data.ibm_resource_group.rg.id
  service           = "cloud-object-storage"
  plan              = "lite"
  location          = "global"
}

resource "ibm_resource_instance" "activity_tracker" {
  name              = "activity_tracker"
  resource_group_id = data.ibm_resource_group.rg.id
  service           = "logdnaat"
  plan              = "lite"
  location          = var.region
}
resource "ibm_resource_instance" "metrics_monitor" {
  name              = "metrics_monitor"
  resource_group_id = data.ibm_resource_group.rg.id
  service           = "sysdig-monitor"
  plan              = "lite"
  location          = var.region
  parameters        = {
    default_receiver = true
  }
}

resource "ibm_cos_bucket" "standard-ams03" {
  bucket_name          = "${lower(random_string.random.result)}-demo"
  resource_instance_id = ibm_resource_instance.cos_instance.id
  single_site_location = "ams03"
  storage_class        = "standard"
}
