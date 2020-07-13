provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  ibmcloud_timeout = 300
  generation       = var.generation
  region           = var.vpc_region
}

data "ibm_resource_group" "group" {
  name = var.resource_group
}

resource "ibm_is_vpc" "vpc" {
  name           = "${var.resources_prefix}-vpc"
  resource_group = data.ibm_resource_group.group.id
}

resource "ibm_resource_instance" "kp_data" {
  name              = "${var.resources_prefix}-kp-data"
  service           = "kms"
  plan              = "tiered-pricing"
  location          = var.vpc_region
  resource_group_id = data.ibm_resource_group.group.id
}

resource "ibm_kp_key" "key_protect" {
  key_protect_id = ibm_resource_instance.kp_data.guid
  key_name       = "${var.resources_prefix}-kp-data"
  standard_key   = false
}

resource "ibm_iam_authorization_policy" "policy" {
  source_service_name = "server-protect"
  source_resource_group_id = data.ibm_resource_group.group.id
  target_service_name = "kms"
  target_resource_group_id = data.ibm_resource_group.group.id
  roles               = ["Reader"]
}

resource "ibm_is_volume" "vsi_database_volume" {
  count          = 1
  name           = "${var.resources_prefix}-data-${count.index + 1}"
  profile        = "custom"
  zone           = "${var.vpc_region}-${count.index + 1}"
  iops           = 6000
  capacity       = 100
  resource_group = data.ibm_resource_group.group.id

  # Enable for Gen 1, Disable for Gen 2 since there is only Provider managed encryption currently. Note the Key_Protect service and key are still created.
  encryption_key = var.generation == 1 ? ibm_kp_key.key_protect.crn : var.null
}