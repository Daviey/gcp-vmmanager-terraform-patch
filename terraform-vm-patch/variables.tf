# variables.tf - Variables for the VM Manager patch deployment

variable "project_id" {
  description = "GCP project ID where the patch deployment will be created"
  type        = string
}

variable "deployment_name" {
  description = "Name for the patch deployment"
  type        = string
  default     = "apt-system-update-template"
}

variable "target_labels" {
  description = "List of label maps to target specific VM groups"
  type        = list(map(string))
  default     = [{ "os-type" = "debian-ubuntu" }]
}

variable "target_zones" {
  description = "List of zones to target (if empty, targets all zones)"
  type        = list(string)
  default     = []
}

variable "target_name_prefixes" {
  description = "List of instance name prefixes to target"
  type        = list(string)
  default     = []
}

variable "target_all_instances" {
  description = "Whether to target all instances (use carefully)"
  type        = bool
  default     = false
}

variable "timezone" {
  description = "Timezone for the patch schedule"
  type        = string
  default     = "Europe/London"
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

variable "schedule_frequency" {
  description = "Frequency of the patch schedule (DAILY, WEEKLY, MONTHLY)"
  type        = string
  default     = "WEEKLY"
  validation {
    condition     = contains(["DAILY", "WEEKLY", "MONTHLY"], var.schedule_frequency)
    error_message = "Frequency must be one of: DAILY, WEEKLY, MONTHLY."
  }
}

variable "schedule_day_of_week" {
  description = "Day of the week for patching (only used when frequency is WEEKLY or MONTHLY)"
  type        = string
  default     = "SUNDAY"
  validation {
    condition     = contains(["MONDAY", "TUESDAY", "WEDNESDAY", "THURSDAY", "FRIDAY", "SATURDAY", "SUNDAY"], var.schedule_day_of_week)
    error_message = "Day of week must be one of: MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY."
  }
}

variable "schedule_week_ordinal" {
  description = "Week ordinal for monthly schedules (only used when frequency is MONTHLY)"
  type        = number
  default     = 1
  validation {
    condition     = var.schedule_week_ordinal >= 1 && var.schedule_week_ordinal <= 4
    error_message = "Week ordinal must be between 1 and 4."
  }
}

variable "apt_excludes" {
  description = "List of package names to exclude from the upgrade"
  type        = list(string)
  default     = []
}

variable "rollout_mode" {
  description = "Mode for rolling out the patch (ZONE_BY_ZONE or CONCURRENT_ZONES)"
  type        = string
  default     = "ZONE_BY_ZONE"
  validation {
    condition     = contains(["ZONE_BY_ZONE", "CONCURRENT_ZONES"], var.rollout_mode)
    error_message = "Rollout mode must be one of: ZONE_BY_ZONE, CONCURRENT_ZONES."
  }
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
