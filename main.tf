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

module "label" {
  source = "git::https://github.com/MITLibraries/tf-mod-name?ref=master"
  name   = "${var.name}"
  tags   = "${var.tags}"
}

resource "aws_ecr_repository" "default" {
  name = "${module.label.name}"
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

resource "aws_ecr_lifecycle_policy" "default" {
  repository = "${aws_ecr_repository.default.name}"

  policy = <<EOF
{
  "rules": [{
    "rulePriority": 1,
    "description": "Rotate images when reach ${var.max_image_count} images stored",
    "selection": {
      "tagStatus": "any",
      "tagPrefixList": ["${terraform.workspace}"],
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
