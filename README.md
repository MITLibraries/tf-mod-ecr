# Terraform ECR module

This module is used to create an [`AWS ECR Docker Container registry`](https://aws.amazon.com/ecr/). It is originally from [here](https://github.com/cloudposse/terraform-aws-ecr), and has been modified to fit our needs.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| max\_image\_count | How many Docker Image versions AWS ECR will store | string | `5` | no |
| name | The Name of the application or solution  (e.g. `bastion` or `portal`) | string | - | yes |
| tags | Additional tags (e.g. `map('BusinessUnit','XYZ')`) | map | `<map>` | no |

## Outputs

| Name | Description |
|------|-------------|
| policy\_login\_arn | The IAM Policy ARN to be given access to login in ECR |
| policy\_login\_name | The IAM Policy name to be given access to login in ECR |
| policy\_read\_arn | The IAM Policy ARN to be given access to pull images from ECR |
| policy\_read\_name | The IAM Policy name to be given access to pull images from ECR |
| policy\_readwrite\_arn | The IAM policy ARN to be given read/write access to ECR |
| policy\_readwrite\_name | The IAM policy name to be given read/write access to ECR |
| policy\_write\_arn | The IAM Policy ARN to be given access to push images to ECR |
| policy\_write\_name | The IAM Policy name to be given access to push images to ECR |
| registry\_id | Registry ID |
| registry\_url | Registry URL |
| repository\_name | Registry name |

