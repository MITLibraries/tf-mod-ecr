output "registry_id" {
  value       = "${aws_ecr_repository.default.registry_id}"
  description = "Registry ID"
}

output "registry_url" {
  value       = "${aws_ecr_repository.default.repository_url}"
  description = "Registry URL"
}

output "repository_name" {
  value       = "${aws_ecr_repository.default.name}"
  description = "Registry name"
}

output "policy_login_name" {
  value       = "${aws_iam_policy.login.name}"
  description = "The IAM Policy name to be given access to login in ECR"
}

output "policy_login_arn" {
  value       = "${aws_iam_policy.login.arn}"
  description = "The IAM Policy ARN to be given access to login in ECR"
}

output "policy_read_name" {
  value       = "${aws_iam_policy.read.name}"
  description = "The IAM Policy name to be given access to pull images from ECR"
}

output "policy_read_arn" {
  value       = "${aws_iam_policy.read.arn}"
  description = "The IAM Policy ARN to be given access to pull images from ECR"
}

output "policy_write_name" {
  value       = "${aws_iam_policy.write.name}"
  description = "The IAM Policy name to be given access to push images to ECR"
}

output "policy_write_arn" {
  value       = "${aws_iam_policy.write.arn}"
  description = "The IAM Policy ARN to be given access to push images to ECR"
}

output "policy_default_name" {
  value       = "${aws_iam_policy.default.name}"
  description = "The IAM Policy name to be given access to push/pull images from ECR"
}

output "policy_default_arn" {
  value       = "${aws_iam_policy.default.arn}"
  description = "The IAM Policy ARN to be given acces to push/pull images from ECR"
}
