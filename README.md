# Cloud Pak for Data, db2u operator gitops module

Module to provision a gitops repo with the resources necessary to provision a Cloud Pak for data, db2u operator on a cluster. In order to provision db2u operator, the following steps are performed:

1. Add the db2u operator chart to the gitops repo (charts/ibm-db2u-operator)

This module is required to install db2oltp Subscription and Data vertulization etc.

# Starter kit for a Terraform GitOps module

This is a Starter kit to help with the creation of Terraform modules. The basic structure of a Terraform module is fairly
simple and consists of the following basic values:

## Software dependencies

The module depends on the following software components:

### Command-line tools

- terraform - > v0.15
- kubectl

### Terraform providers

- IBM Cloud provider >= 1.5.3
- Helm provider >= 1.1.1 (provided by Terraform)

## Module dependencies

This module makes use of the output from other modules:

- GitOps - github.com/cloud-native-toolkit/terraform-tools-gitops.git
- Namespace - github.com/cloud-native-toolkit/terraform-gitops-namespace.git
- gitops_cp_foundation - github.com/cloud-native-toolkit/terraform-gitops-cp-foundational-services.git
- gitops_ibm_catalogs - github.com/cloud-native-toolkit/terraform-gitops-cp-catalogs.git
- gitops_cp4d_operator - github.com/cloud-native-toolkit/terraform-gitops-cp4d-operator.git
- gitops-cp4d-instance - github.com/cloud-native-toolkit/terraform-gitops-cp4d-instance.git

## Example usage

```hcl-terraform
module "db2u" {
  depends_on = [
    module.gitops_ibm_catalogs,
    module.gitops_cp4d_operator
  ]
  
  source = "github.com/cloud-native-toolkit/terraform-gitops-db2u-operator.git"

  gitops_config = module.gitops.gitops_config
  git_credentials = module.gitops.git_credentials
  server_name = module.gitops.server_name  
  operator_namespace = "cpd-operators"
  kubeseal_cert = module.gitops.sealed_secrets_cert
}
```
## Anatomy of the GitOps module repository

An automation modules is created from a template repository that includes a skeleton of the module logic and the automation framework to validate and release the module.

### Module metadata

The module metadata adds extra descriptive information about the module that is used to build out the module catalog.

```yaml
name: gitops-db2
type: gitops
description: Module to populate a gitops repo with the resources to provision db2
tags:
  - tools
  - gitops
softwareProvider: ibm-cp
versions:
  - platforms:
      - kubernetes
      - ocp3
      - ocp4
    dependencies:
      - id: gitops
        refs:
          - source: github.com/cloud-native-toolkit/terraform-tools-gitops.git
            version: ">= 1.1.0"
      - id: namespace
        refs:
          - source: github.com/cloud-native-toolkit/terraform-gitops-namespace.git
            version: ">= 1.0.0"
      - id: gitops_ibm_catalogs
        refs:
          - source: github.com/cloud-native-toolkit/terraform-gitops-cp-catalogs.git
            version: ">= 1.0.0"
      - id: gitops_cp_foundation
        refs:
          - source: github.com/cloud-native-toolkit/terraform-gitops-cp-foundational-services.git
            version: ">= 1.0.0"
      - id: gitops_cp4d_operator
        refs:
          - source: github.com/cloud-native-toolkit/terraform-gitops-cp4d-operator.git
            version: ">= 1.0.0"
      - id: gitops-cp4d-instance
        refs:
          - source: github.com/cloud-native-toolkit/terraform-gitops-cp4d-instance.git
            version: ">= 1.0.0"      
    variables:
      - name: gitops_config
        moduleRef:
          id: gitops
          output: gitops_config
      - name: git_credentials
        moduleRef:
          id: gitops
          output: git_credentials
      - name: server_name
        moduleRef:
          id: gitops
          output: server_name
      - name: operator_namespace
        moduleRef:
          id: gitops_cp4d_operator
          output: operator_namespace
      - name: kubeseal_cert
        moduleRef:
          id: gitops
          output: sealed_secrets_cert

```

