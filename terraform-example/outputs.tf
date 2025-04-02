output "patch_deployment_name" {
  description = "The full name of the patch deployment"
  value       = module.apt_upgrade_patch.patch_deployment_name
}

output "patch_deployment_id" {
  description = "The ID of the patch deployment"
  value       = module.apt_upgrade_patch.patch_deployment_id
}
