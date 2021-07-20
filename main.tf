terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
      version = "3.1.1"
    }
  }
}

provider "nsxt" {
  host                  = var.nsx_manager
  username              = var.nsx_username
  password              = var.nsx_password
  allow_unverified_ssl  = true
  max_retries           = 10
  retry_min_delay       = 500
  retry_max_delay       = 5000
  retry_on_status_codes = [429]
}

variable "nsx_manager" {
  description = "NSX Manager IP / FQDN"
  type        = string
}

variable "nsx_username" {
  description = "NSX administrator username"
  type        = string
  sensitive   = true
}
variable "nsx_password" {
  description = "NSX administrator password"
  type        = string
  sensitive   = true
}

resource "nsxt_policy_group" "wordpress" {
  display_name = "Test Group"
  description  = "Terraform provisioned Group"
  criteria {
    condition {
      key         = "Tag"
      member_type = "VirtualMachine"
      operator    = "EQUALS"
      value       = "application|wordpress"
    }
  }
}
