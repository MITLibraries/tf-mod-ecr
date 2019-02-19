/**
 * # Terraform ECR module
 *
 * This module is used to create an [`AWS ECR Docker Container registry`](https://aws.amazon.com/ecr/). It is originally from [here](https://github.com/cloudposse/terraform-aws-ecr), and has been modified to fit our needs.
 **/
data "aws_iam_policy_document" "login" {
  statement {
    sid     = "ECRGetAuthorizationToken"
    effect  = "Allow"
    actions = ["ecr:GetAuthorizationToken"]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "write" {
  statement {
    sid    = "ECRGetAuthorizationToken"
    effect = "Allow"

    actions = [
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:PutImage",
    ]

    resources = ["${aws_ecr_repository.default.arn}"]
  }
}

data "aws_iam_policy_document" "read" {
  statement {
    sid    = "ECRGetAuthorizationToken"
    effect = "Allow"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
    ]

    resources = ["${aws_ecr_repository.default.arn}"]
  }
}

data "aws_iam_policy_document" "rw" {
  statement {
    actions = [
      "ecr:CreateRepository",
      "ecr:GetAuthorizationToken",
    ]

    resources = ["*"]
  }

  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:CompleteLayerUpload",
      "ecr:DeleteRepository",
      "ecr:DescribeImages",
      "ecr:DescribeRepositories",
      "ecr:InitiateLayerUpload",
      "ecr:ListImages",
      "ecr:ListTagsForResource",
      "ecr:PutImage",
      "ecr:TagResource",
      "ecr:UntagResource",
      "ecr:UploadLayerPart",
    ]

    resources = ["${aws_ecr_repository.default.arn}"]
  }
}

module "label" {
  source = "git::https://github.com/MITLibraries/tf-mod-name?ref=master"
  name   = "${var.name}"
  tags   = "${var.tags}"
}

resource "aws_ecr_repository" "default" {
  name = "${module.label.name}"
  tags = "${module.label.tags}"
}

resource "aws_iam_policy" "login" {
  name        = "${module.label.name}-login"
  description = "Allow IAM Users to call ecr:GetAuthorizationToken"
  policy      = "${data.aws_iam_policy_document.login.json}"
}

resource "aws_iam_policy" "read" {
  name        = "${module.label.name}-read"
  description = "Allow IAM Users to pull from ECR"
  policy      = "${data.aws_iam_policy_document.read.json}"
}

resource "aws_iam_policy" "write" {
  name        = "${module.label.name}-write"
  description = "Allow IAM Users to push into ECR"
  policy      = "${data.aws_iam_policy_document.write.json}"
}

resource "aws_iam_policy" "readwrite" {
  name        = "${module.label.name}-readwrite"
  description = "Allow IAM users to read/write into ECR"
  policy      = "${data.aws_iam_policy_document.rw.json}"
}

resource "aws_ecr_lifecycle_policy" "default" {
  repository = "${aws_ecr_repository.default.name}"

  policy = <<EOF
{
  "rules": [{
    "rulePriority": 1,
    "description": "Rotate images when reach ${var.max_image_count} images stored",
    "selection": {
      "tagStatus": "any",
      "countType": "imageCountMoreThan",
      "countNumber": ${var.max_image_count}
    },
    "action": {
      "type": "expire"
    }
  }]
}
EOF
}
