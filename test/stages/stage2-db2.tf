module "db2" {
  source = "./module"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  catalog = module.cp_catalogs.catalog_ibmoperators
  platform_navigator_name = module.cp_platform_navigator.name
}
