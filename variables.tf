variable "name" {
  description = "The Name of the application or solution  (e.g. `bastion` or `portal`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`)"
}

variable "max_image_count" {
  type        = string
  description = "How many Docker Image versions AWS ECR will store"
  default     = "5"
}

