provider "google" {
  # Configure the Google Provider
  # credentials = file("path/to/your/service-account-key.json")
  project = var.project_id
  region  = var.region
}

module "apt_upgrade_patch" {
  source          = "../terraform-vm-patch"
  project_id      = var.project_id
  deployment_name = var.deployment_name
  
  # Target specific VMs
  target_labels   = var.target_labels
  
  # Schedule settings
  timezone            = var.timezone
  schedule_frequency  = var.schedule_frequency
  schedule_day_of_week = var.schedule_day_of_week
  schedule_hour       = var.schedule_hour
  schedule_minute     = var.schedule_minute
  
  # Rollout configuration
  rollout_mode         = var.rollout_mode
  concurrent_instances = var.concurrent_instances
  duration_seconds     = var.duration_seconds
}
