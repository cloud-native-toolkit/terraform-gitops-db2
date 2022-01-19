

module "gitops_ibm_catalogs" {
  source = "github.com/cloud-native-toolkit/terraform-gitops-cp-catalogs"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name
  namespace = var.operator_namespace
  kubeseal_cert = module.gitops.sealed_secrets_cert
  entitlement_key = "test"
}