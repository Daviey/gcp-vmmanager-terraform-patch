variable "project_id" {
  description = "GCP project ID where the patch deployment will be created"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

variable "deployment_name" {
  description = "Name for the patch deployment"
  type        = string
  default     = "apt-system-update"
}

variable "target_labels" {
  description = "List of label maps to target specific VM groups"
  type        = list(map(string))
  default     = [{ "os-type" = "debian-ubuntu" }]
}

variable "timezone" {
  description = "Timezone for the patch schedule"
  type        = string
  default     = "Europe/London"
}

variable "schedule_frequency" {
  description = "Frequency of the patch schedule (DAILY, WEEKLY, MONTHLY)"
  type        = string
  default     = "WEEKLY"
}

variable "schedule_day_of_week" {
  description = "Day of the week for patching"
  type        = string
  default     = "SUNDAY"
}

variable "schedule_hour" {
  description = "Hour of the day for patching (0-23)"
  type        = number
  default     = 2
}

variable "schedule_minute" {
  description = "Minute of the hour for patching (0-59)"
  type        = number
  default     = 0
}

variable "rollout_mode" {
  description = "Mode for rolling out the patch"
  type        = string
  default     = "ZONE_BY_ZONE"
}

variable "concurrent_instances" {
  description = "Number of VMs to patch concurrently"
  type        = number
  default     = 10
}

variable "duration_seconds" {
  description = "Maximum duration of the patch job in seconds"
  type        = number
  default     = 3600
}
