module "gitops-bootstrap" {
  source = "github.com/cloud-native-toolkit/terraform-util-gitops-bootstrap.git"

  cluster_config_file = module.dev_cluster.config_file_path
  gitops_repo_url     = module.gitops.config_repo_url
  git_username        = module.gitops.config_username
  git_token           = module.gitops.config_token
  bootstrap_path      = module.gitops.bootstrap_path
  sealed_secret_cert  = module.cert.cert
  sealed_secret_private_key = module.cert.private_key
  prefix              = "openshift-operators-db2u-operator"
  kubeseal_namespace  = var.kubeseal_namespace
  create_webhook      = true
}
