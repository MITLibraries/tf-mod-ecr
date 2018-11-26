This module is used to create an [`AWS ECR Docker Container registry`](https://aws.amazon.com/ecr/).
It is originally from [here](https://github.com/cloudposse/terraform-aws-ecr), and has been modified to fit our needs.

You can either provide an existing role or this module will create the require roles and policies.

## Inputs

| Name            | Description                                                           |  Type  |  Default | Required |
| --------------- | --------------------------------------------------------------------- | :----: | :------: | :------: |
| max_image_count | How many Docker Image versions AWS ECR will store                     | string |    `5`   |    no    |
| name            | The Name of the application or solution  (e.g. `bastion` or `portal`) | string |     -    |    yes   |
| roles           | Principal IAM roles to provide with access to the ECR                 |  list  | `<list>` |    no    |
| tags            | Additional tags (e.g. `map('BusinessUnit','XYZ')`)                    |   map  |  `<map>` |    no    |

## Outputs

| Name              | Description                                                    |
| ----------------- | -------------------------------------------------------------- |
| policy_login_arn  | The IAM Policy ARN to be given access to login in ECR          |
| policy_login_name | The IAM Policy name to be given access to login in ECR         |
| policy_read_arn   | The IAM Policy ARN to be given access to pull images from ECR  |
| policy_read_name  | The IAM Policy name to be given access to pull images from ECR |
| policy_write_arn  | The IAM Policy ARN to be given access to push images to ECR    |
| policy_write_name | The IAM Policy name to be given access to push images to ECR   |
| registry_id       | Registry ID                                                    |
| registry_url      | Registry URL                                                   |
| repository_name   | Registry name                                                  |
| role_arn          | Assume Role ARN to get registry access                         |
| role_name         | Assume Role name to get registry access                        |
