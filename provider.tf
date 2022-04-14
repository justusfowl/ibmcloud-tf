

provider "ibm" {
    # Enabling VPN across zones for KMS clusters
    generation = 2
    ibmcloud_api_key   = var.ibmcloud_api_key
    region = var.region
}