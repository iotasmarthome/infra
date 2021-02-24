output "iota_hassio_eks_kubeconfig" {
  value = module.iota_hassio_eks.kubeconfig
}

output "iota_hassio_eks_kubeconfig_filename" {
  value = module.iota_hassio_eks.kubeconfig_filename
}

output "iota_hassio_eks_arn" {
  value = module.iota_hassio_eks.worker_iam_role_arn
}
