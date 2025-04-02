# Terraform VM Manager Patch Module

This Terraform module creates a Google Cloud VM Manager patch deployment for automatically updating Debian/Ubuntu VMs with `apt update` and `apt dist-upgrade`.

## Usage

```hcl
module "apt_upgrade_patch" {
  source          = "./terraform-vm-patch"
  project_id      = "my-project-id"
  deployment_name = "weekly-apt-upgrade"
  
  # Optional: Override default values
  target_labels   = [{ "environment" = "production" }]
  schedule_frequency = "WEEKLY"
  schedule_day_of_week = "SUNDAY"
  schedule_hour = 2
}
```

## Variables

See `variables.tf` for a complete list of configurable variables.

## Requirements

- Terraform >= 0.14
- Google Provider >= 3.60
