# main.tf - Terraform module for GCP VM Manager patch deployment

resource "google_os_config_patch_deployment" "apt_update_upgrade" {
  provider = google
  project  = var.project_id

  patch_deployment_id = var.deployment_name
  description         = "Scheduled apt update and dist-upgrade for Debian/Ubuntu VMs"

  instance_filter {
    dynamic "group_labels" {
      for_each = var.target_labels
      content {
        labels = group_labels.value
      }
    }

    zones                  = var.target_zones
    instance_name_prefixes = var.target_name_prefixes
    all                    = var.target_all_instances
  }

  recurring_schedule {
    time_zone {
      id = var.timezone
    }

    time_of_day {
      hours   = var.schedule_hour
      minutes = var.schedule_minute
      seconds = 0
      nanos   = 0
    }

    frequency = var.schedule_frequency

    dynamic "weekly" {
      for_each = var.schedule_frequency == "WEEKLY" ? [1] : []
      content {
        day_of_week = var.schedule_day_of_week
      }
    }

    dynamic "monthly" {
      for_each = var.schedule_frequency == "MONTHLY" ? [1] : []
      content {
        week_day_of_month {
          week_ordinal = var.schedule_week_ordinal
          day_of_week  = var.schedule_day_of_week
        }
      }
    }
  }

  patch_config {
    apt {
      type     = "DIST"
      excludes = var.apt_excludes
    }

    pre_step {
      linux_exec_step_config {
        interpreter = "SHELL"
        executable  = file("${path.module}/scripts/pre-patch.sh")
      }
    }

    post_step {
      linux_exec_step_config {
        interpreter = "SHELL"
        executable  = file("${path.module}/scripts/post-patch.sh")
      }
    }
  }

  rollout {
    mode = var.rollout_mode
    disruption_budget {
      fixed = var.concurrent_instances
    }
  }

  duration = "${var.duration_seconds}s"
}
